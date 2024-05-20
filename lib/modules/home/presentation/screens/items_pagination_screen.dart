import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manger_app/core/constants/app_colors.dart';
import 'package:task_manger_app/core/core_component/show_snack_bar.dart';
import 'package:task_manger_app/core/utils/base_state.dart';
import 'package:task_manger_app/core/utils/db_helper.dart';
import 'package:task_manger_app/generated/locale_keys.g.dart';
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';
import 'package:task_manger_app/modules/home/domain/repository/home_repository.dart';
import 'package:task_manger_app/modules/home/presentation/blocs/task_management_bloc/task_management_bloc.dart';
import 'package:task_manger_app/modules/home/presentation/components/show_add_dialog.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../core/core_component/failure_component.dart';
import '../../../../core/core_component/pagination_list_view_component.dart';
import '../../../../core/utils/base_pagination_bloc/pagination_state.dart';
import '../blocs/items_pagination_bloc/items_pagination_bloc.dart';
import '../blocs/items_pagination_bloc/items_pagination_event.dart';

class ItemsPaginationScreen extends StatelessWidget {
  const ItemsPaginationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(LocaleKeys.toDoList.tr(context: context),
            style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          IconButton(
              onPressed: () => showUpdatePaymentUrlsDialog(context),
              icon: const Icon(
                Icons.add,
                color: AppColors.white,
              )),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ItemsPaginationBloc>(
            create: (context) =>
                sl<ItemsPaginationBloc>()..add(const GetItemsPaginationEvent()),
          ),
          BlocProvider<TaskManagementBloc>(
              create: (context) => sl<TaskManagementBloc>()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ItemsPaginationBloc>(
              create: (context) => ItemsPaginationBloc(
                sl<HomeRepository>(),
                DatabaseHelper(),
              )..add(const GetItemsPaginationEvent()),
            ),
            BlocProvider<TaskManagementBloc>(
              create: (context) => sl<TaskManagementBloc>(),
            ),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<TaskManagementBloc, BaseState<ItemEntity>>(
                listener: (context, state) {
                  _manageTaskListener(context, state);
                },
              ),
            ],
            child: BlocBuilder<ItemsPaginationBloc,
                PaginationState<List<ItemEntity>>>(builder: (context, state) {
              if (state.isError) {
                return FailureComponent(failure: state.failure);
              } else if (state.isSuccess) {
                return PaginatedListView<ItemEntity>(
                  padding: const EdgeInsetsDirectional.all(16),
                  onRefresh: () {
                    context
                        .read<ItemsPaginationBloc>()
                        .add(const RefreshItemsPaginationEvent());
                  },
                  onCallMoreData: () => context
                      .read<ItemsPaginationBloc>()
                      .add(const GetMoreItemsPaginationEvent()),
                  state: state,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (int index) => Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        state.data![index].todo,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        state.data![index].completed == false
                            ? LocaleKeys.statusNotCompleted.tr(context: context)
                            : LocaleKeys.statusCompleted.tr(context: context),
                        style: TextStyle(
                            color: state.data![index].completed == false
                                ? AppColors.red
                                : AppColors.green),
                      ),
                      trailing: SizedBox(
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<TaskManagementBloc>().add(
                                    UpdateToDoItemEvent(state.data![index].id));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<TaskManagementBloc>().add(
                                    DeleteToDoItemEvent(state.data![index].id));
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ),
      ),
    );
  }

  void _manageTaskListener(BuildContext context, BaseState<ItemEntity> state) {
    if (state.isError) {
      showSnackBar(context, state.errorMessage);
    } else if (state.isSuccess) {
      showSnackBar(
        context,
        LocaleKeys.successfully.tr(context: context),
      );
      // Refresh the items list after a successful update or delete
      context
          .read<ItemsPaginationBloc>()
          .add(const RefreshItemsPaginationEvent());
      context.read<ItemsPaginationBloc>().add(const GetItemsPaginationEvent());
    }
  }
}
