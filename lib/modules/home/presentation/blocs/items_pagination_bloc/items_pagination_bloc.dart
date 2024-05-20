import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_manger_app/core/errors/failure.dart';
import 'package:task_manger_app/core/utils/base_pagination_bloc/pagination_state.dart';
import 'package:task_manger_app/core/utils/db_helper.dart';
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';
import 'package:task_manger_app/modules/home/domain/parameters/items_pagination_parameters.dart';
import 'package:task_manger_app/modules/home/domain/repository/home_repository.dart';
import 'package:task_manger_app/modules/home/presentation/blocs/items_pagination_bloc/items_pagination_event.dart';

import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/base_pagination_bloc/pagination_bloc.dart';

class ItemsPaginationBloc
    extends PaginationBloc<ItemsPaginationEvent, ItemEntity> {
  final HomeRepository homeRepository;
  final DatabaseHelper databaseHelper;

  ItemsPaginationBloc(this.homeRepository, this.databaseHelper)
      : super(initialMaxResultCount: 8) {
    on<GetItemsPaginationEvent>(
      fetchDataFirstTime,
    );
    on<GetMoreItemsPaginationEvent>(
      loadMoreData,
    );
    on<RefreshItemsPaginationEvent>(
      refresh,
    );
  }
  Future<bool> isOnline() async {
    return await InternetConnectionChecker().hasConnection;
  }

  @override
  Future<void> fetchDataFirstTime(
    ItemsPaginationEvent event,
    Emitter<PaginationState<List<ItemEntity>>> emit,
  ) async {
    emit(state.loading());

    if (await isOnline()) {
      final result = await homeRepository.fetchPaginationData(
        ItemsPaginationParameters(
          skip: state.skipCount,
          limit: state.maxResultCount,
        ),
      );

      logger.d(
        "============ Fetch Data =============== \n skipCount: ${state.skipCount} \n maxResultCount: ${state.maxResultCount}",
      );

      result.fold(
        (l) => _emitFailure(l, emit),
        (r) async {
          _handleData(r, emit);
          await databaseHelper.clearItems();

          for (var item in r) {
            await databaseHelper.insertItem(item);
          }
        },
      );
    } else {
      final cachedItems = await databaseHelper.getItems();
      if (cachedItems.isNotEmpty) {
        emit(state.success(cachedItems));
      } else {
        emit(state.error(const Failure(
            "No internet connection and no cached data available.")));
      }
    }
  }

  @override
  FutureOr<void> loadMoreData(ItemsPaginationEvent event,
      Emitter<PaginationState<List<ItemEntity>>> emit) async {
    if (await isOnline()) {
      final result = await homeRepository.fetchPaginationData(
          ItemsPaginationParameters(
              skip: state.skipCount, limit: state.maxResultCount));
      logger.d(
          "============ Load More =============== \n skipCount: ${state.skipCount} \n maxResultCount: ${state.maxResultCount}");
      result.fold(
        (l) => _emitFailure(l, emit),
        (r) async {
          _handleData(r, emit);
          for (var item in r) {
            await databaseHelper.insertItem(item);
          }
        },
      );
    } else {
      final cachedItems = await databaseHelper.getItems();
      if (cachedItems.isNotEmpty) {
        emit(state.success(cachedItems));
      } else {
        emit(state.error(const Failure(
            "No internet connection and no cached data available.")));
      }
    }
  }

  @override
  FutureOr<void> refresh(ItemsPaginationEvent event,
      Emitter<PaginationState<List<ItemEntity>>> emit) async {
    emit(state.refresh());
    logger.d(
        "============ Refresh State =============== \n skipCount: ${state.skipCount} \n maxResultCount: ${state.maxResultCount}");
  }

  void _emitFailure(
      Failure failure, Emitter<PaginationState<List<ItemEntity>>> emit) {
    emit(state.data == null
        ? state.error(failure)
        : state.copyWith(failure: failure));
  }

  void _handleData(
      List<ItemEntity> data, Emitter<PaginationState<List<ItemEntity>>> emit) {
    final hasReachedMax =
        data.isNotEmpty ? data.length < state.maxResultCount : true;
    final result = hasReachedMax
        ? _appendLastElements(data)
        : _appendPage(data, hasReachedMax);
    emit(result);
  }

  PaginationState<List<ItemEntity>> _appendPage(
      List<ItemEntity> newItems, bool hasReachedMax) {
    final data = state.data ?? [];
    final updatedData = List<ItemEntity>.from(data)..addAll(newItems);
    final skipCount = updatedData.length;
    return state.success(updatedData, skipCount, hasReachedMax);
  }

  PaginationState<List<ItemEntity>> _appendLastElements(
      List<ItemEntity> newItems) {
    return _appendPage(newItems, true);
  }
}
