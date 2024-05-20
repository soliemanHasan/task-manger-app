
import 'package:task_manger_app/modules/home/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.id,
    required super.completed,
    required super.todo,
    required super.userId,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }
}
