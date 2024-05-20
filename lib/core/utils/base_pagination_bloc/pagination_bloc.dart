import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../errors/failure.dart';
import 'pagination_state.dart';

abstract class PaginationBloc<Event, Entity>
    extends Bloc<Event, PaginationState<List<Entity>>> {
  PaginationBloc({required int initialMaxResultCount})
      : super(PaginationState<List<Entity>>(
      maxResultCount: initialMaxResultCount));

  FutureOr<void> fetchDataFirstTime(Event event,
      Emitter<PaginationState<List<Entity>>> emit);

  FutureOr<void> loadMoreData(Event event,
      Emitter<PaginationState<List<Entity>>> emit);

  FutureOr<void> refresh(Event event,
      Emitter<PaginationState<List<Entity>>> emit);

  void handleResult(Either<Failure, List<Entity>> result,
      Emitter<PaginationState<List<Entity>>> emit) {
    result.fold(
          (failure) => _emitFailure(failure, emit),
          (data) => _handleData(data, emit),
    );
  }

  void _emitFailure(Failure failure, Emitter<PaginationState<List<Entity>>> emit) {
    emit(state.data == null ? state.error(failure) : state.copyWith(failure: failure));
  }

  void _handleData(List<Entity> data, Emitter<PaginationState<List<Entity>>> emit) {
    final hasReachedMax = data.isNotEmpty ? data.length < state.maxResultCount : true;
    final result = hasReachedMax ? _appendLastElements(data) : _appendPage(data, hasReachedMax);
    emit(result);
  }

  PaginationState<List<Entity>> _appendPage(List<Entity> newItems, bool hasReachedMax) {
    final data = state.data ?? [];
    final updatedData = List<Entity>.from(data)..addAll(newItems);
    final skipCount = updatedData.length;
      return state.success(updatedData, skipCount, hasReachedMax);
  }

  PaginationState<List<Entity>> _appendLastElements(List<Entity> newItems) {
    return _appendPage(newItems, true);
  }
}
