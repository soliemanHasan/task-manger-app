import 'package:task_manger_app/modules/home/data/models/item_model.dart';
import 'package:task_manger_app/modules/home/domain/parameters/add_item_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/items_pagination_parameters.dart';
import 'package:task_manger_app/modules/home/domain/parameters/update_item_parameters.dart';

import '../../../../core/constants/apis_urls.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/utils/app_response.dart';
import 'home_data_source.dart';

class HomeDataSourceImp extends HomeDataSource {
  @override
  Future<List<ItemModel>> fetchPaginationData(
      ItemsPaginationParameters parameters) async {
    AppResponse response = await ApiServices()
        .get(ApisUrls.getToDoList(parameters.limit, parameters.skip));
    return response.toList(ItemModel.fromJson, index: "todos");
  }

  @override
  Future<ItemModel> updateItem(UpdateItemParameters parameters) async {
    AppResponse response =
        await ApiServices().put(ApisUrls.updateItem(parameters.id));
    return ItemModel.fromJson(response.data);
  }

  @override
  Future<ItemModel> deleteItem(UpdateItemParameters parameters) async {
    AppResponse response =
        await ApiServices().delete(ApisUrls.deleteItem(parameters.id));
    return ItemModel.fromJson(response.data);
  }

  @override
  Future<ItemModel> addItem(AddItemParameters parameters) async {
    AppResponse response = await ApiServices().post(
      ApisUrls.addItem,
      data: parameters.toJson(),
    );
    return ItemModel.fromJson(response.data);
  }
}
