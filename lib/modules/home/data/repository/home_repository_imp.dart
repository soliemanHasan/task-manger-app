
import 'package:dartz/dartz.dart';
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';
import 'package:task_manger_app/modules/home/domain/parameters/add_item_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/items_pagination_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/update_item_parameters.dart';
import 'package:task_manger_app/modules/home/domain/repository/home_repository.dart';

import '../../../../core/errors/errors_handler.dart';
import '../../../../core/errors/failure.dart';

import '../data_source/home_data_source.dart';

class HomeRepositoryImp extends HomeRepository {
  final HomeDataSource homeDataSource;
  HomeRepositoryImp(this.homeDataSource);



  @override
  Future<Either<Failure, List<ItemEntity>>> fetchPaginationData(ItemsPaginationParameters parameters) {
    return ErrorsHandler.handleEither(() => homeDataSource.fetchPaginationData(parameters));
  }

  @override
  Future<Either<Failure, ItemEntity>> updateItem(UpdateItemParameters parameters) {
    return ErrorsHandler.handleEither(() => homeDataSource.updateItem(parameters));

  }

  @override
  Future<Either<Failure, ItemEntity>> deleteItem(UpdateItemParameters parameters) {
    return ErrorsHandler.handleEither(() => homeDataSource.deleteItem(parameters));

  }

  @override
  Future<Either<Failure, ItemEntity>> addItem(AddItemParameters parameters) {
    return ErrorsHandler.handleEither(() => homeDataSource.addItem(parameters));

  }


}
