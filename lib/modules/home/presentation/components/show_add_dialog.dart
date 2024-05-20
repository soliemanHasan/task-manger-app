import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger_app/core/constants/app_colors.dart';
import 'package:task_manger_app/core/core_component/app_button.dart';
import 'package:task_manger_app/core/core_component/app_text_form_field.dart';
import 'package:task_manger_app/core/core_component/show_snack_bar.dart';
import 'package:task_manger_app/core/services/cache_storage_services.dart';
import 'package:task_manger_app/core/services/service_locator.dart';
import 'package:task_manger_app/core/utils/app_validator.dart';
import 'package:task_manger_app/core/utils/base_state.dart';
import 'package:task_manger_app/generated/locale_keys.g.dart';
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';
import 'package:task_manger_app/modules/home/presentation/blocs/items_pagination_bloc/items_pagination_bloc.dart';
import 'package:task_manger_app/modules/home/presentation/blocs/items_pagination_bloc/items_pagination_event.dart';
import 'package:task_manger_app/modules/home/presentation/blocs/task_management_bloc/task_management_bloc.dart';

void showUpdatePaymentUrlsDialog(
  BuildContext context,
) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const _UpdatePaymentUrlDialog();
    },
  );
}

class _UpdatePaymentUrlDialog extends StatefulWidget {
  const _UpdatePaymentUrlDialog();

  @override
  State<_UpdatePaymentUrlDialog> createState() =>
      _UpdatePaymentUrlDialogState();
}

class _UpdatePaymentUrlDialogState extends State<_UpdatePaymentUrlDialog> {
  final TextEditingController todController = TextEditingController();
  bool isCompleted = false;

  final nameFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskManagementBloc>(),
      child: BlocConsumer<TaskManagementBloc, BaseState<ItemEntity>>(
        listener: _addTaskListener,
        builder: (context, state) {
          return Dialog(
            //backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
              side: const BorderSide(color: AppColors.red),
            ),
            elevation: 1,
            insetPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.w),
            child: Container(
              width: 320.w,
              height: 350.h,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      " add your Task",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    SizedBox(height: 3.w),
                    AppTextFormField(
                      validator: AppValidator.nameValidator,
                      hint: LocaleKeys.enterYourTask.tr(context: context),
                      controller: todController,
                      keyboardType: TextInputType.text,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          " is Complete",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Checkbox(
                          activeColor: AppColors.blue,
                          checkColor: AppColors.blue,
                          value: isCompleted,
                          onChanged: (value) => setState(() {
                            isCompleted = value!;
                          }),
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        SizedBox(width: 20.w),
                        AppButton(
                          width: 100.w,
                          height: 40.h,
                          label: "cancle",
                          onTap: () => context.pop(),
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        AppButton(
                          width: 100.w,
                          height: 40.h,
                          label: "ok",
                          loading: state.isLoading,
                          onTap: () => _addTaskPressed(context, state),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addTaskListener(BuildContext context, BaseState<ItemEntity> state) {
    if (state.isError) {
      showSnackBar(context, state.errorMessage);
      context.pop();
    }

    if (state.isSuccess) {
      showSnackBar(
        context,
        LocaleKeys.taskAddSuccessfully.tr(context: context),
      );
      context.pop();

      sl<ItemsPaginationBloc>().add(const RefreshItemsPaginationEvent());
      sl<ItemsPaginationBloc>().add(const GetItemsPaginationEvent());
    }
  }

  void _addTaskPressed(BuildContext context, BaseState<ItemEntity> state) {
    context.read<TaskManagementBloc>().add(
          AddToDoItemEvent(
              completed: isCompleted,
              toDo: todController.text,
              userId: CacheStorageServices().userId),
        );
    state.isLoading;
  }
}
