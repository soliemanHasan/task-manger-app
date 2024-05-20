// import 'dart:async';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_manger_app/modules/home/domain/entities/category_entity.dart';
// import 'package:task_manger_app/modules/home/domain/parameters/get_category_parameters.dart';
// import 'package:task_manger_app/modules/home/domain/repository/home_repository.dart';
// import '../../../../../core/utils/base_state.dart';

// part 'home_event.dart';

// class HomeBloc extends Bloc<HomeEvent, BaseState<List<CategoryEntity>>> {
//   final HomeRepository homeRepository;

//   HomeBloc(this.homeRepository)
//       : super(const BaseState<List<CategoryEntity>>()) {
//     on<FetchCategoryEvent>(_getHome);
//   }
//   FutureOr<void> _getHome(FetchCategoryEvent event, emit) async {
//     emit(state.loading());
//     final result =
//         await homeRepository.getCategories(GetCategoryParameters(id: event.id));
//     result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
//   }
// }
