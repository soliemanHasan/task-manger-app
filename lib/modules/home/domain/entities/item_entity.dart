import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const ItemEntity(
      {required this.id,
      required this.todo,
      required this.completed,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed == true ? 1 : 0,
      'userId': userId
    };
  }

  @override
  List<Object?> get props => [id, todo, completed, userId];
}
