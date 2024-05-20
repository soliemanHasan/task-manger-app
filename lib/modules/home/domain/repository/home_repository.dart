import 'package:dartz/dartz.dart';
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';
import 'package:task_manger_app/modules/home/domain/parameters/add_item_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/items_pagination_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/update_item_parameters.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ItemEntity>>> fetchPaginationData(
      ItemsPaginationParameters parameters);
  Future<Either<Failure, ItemEntity>> updateItem(
      UpdateItemParameters parameters);
  Future<Either<Failure, ItemEntity>> deleteItem(
      UpdateItemParameters parameters);
  Future<Either<Failure, ItemEntity>> addItem(AddItemParameters parameters);
}
