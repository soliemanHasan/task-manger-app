import 'package:equatable/equatable.dart';
import 'package:task_manger_app/core/services/cache_storage_services.dart';

class AddItemParameters extends Equatable {
  final String toDo;
  final bool completed;
  final int userId;

  const AddItemParameters(
      {required this.completed, required this.toDo, required this.userId});

  Map<String, dynamic> toJson() => {
        "todo": toDo,
        "completed": completed,
        "userId": userId,
      };

  @override
  List<Object?> get props => [toDo, userId, completed];
}
