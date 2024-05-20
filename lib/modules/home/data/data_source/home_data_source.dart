
import 'package:task_manger_app/modules/home/data/models/item_model.dart';
import 'package:task_manger_app/modules/home/domain/parameters/add_item_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/items_pagination_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/update_item_parameters.dart';

abstract class HomeDataSource {
  Future<List<ItemModel>> fetchPaginationData(ItemsPaginationParameters parameters);
  Future<ItemModel> updateItem(UpdateItemParameters parameters);
    Future<ItemModel> deleteItem(UpdateItemParameters parameters);
    Future<ItemModel> addItem(AddItemParameters parameters);

  
}
