import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger_app/core/utils/base_state.dart';
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';
import 'package:task_manger_app/modules/home/domain/parameters/add_item_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/update_item_parameters.dart';
import 'package:task_manger_app/modules/home/domain/repository/home_repository.dart';

part 'task_management_event.dart';

class TaskManagementBloc
    extends Bloc<TaskManagementEvent, BaseState<ItemEntity>> {
  final HomeRepository homeRepository;
  TaskManagementBloc(this.homeRepository)
      : super(const BaseState<ItemEntity>()) {
    on<UpdateToDoItemEvent>(_updateToDoItem);
    on<DeleteToDoItemEvent>(_deleteToDoItem);
    on<AddToDoItemEvent>(
      _addToDoItem,
    );
  }

  FutureOr<void> _updateToDoItem(UpdateToDoItemEvent event, emit) async {
    emit(state.loading());
    final result =
        await homeRepository.updateItem(UpdateItemParameters(event.id));
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }

  FutureOr<void> _deleteToDoItem(DeleteToDoItemEvent event, emit) async {
    emit(state.loading());
    final result =
        await homeRepository.deleteItem(UpdateItemParameters(event.id));
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }

  FutureOr<void> _addToDoItem(AddToDoItemEvent event, emit) async {
    emit(state.loading());
    final result = await homeRepository.addItem(AddItemParameters(
        completed: event.completed, toDo: event.toDo, userId: event.userId));
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }
}
