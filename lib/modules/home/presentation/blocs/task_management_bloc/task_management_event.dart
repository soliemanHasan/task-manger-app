part of 'task_management_bloc.dart';

class TaskManagementEvent extends Equatable {
  const TaskManagementEvent();
  @override
  List<Object?> get props => [];
}

class UpdateToDoItemEvent extends TaskManagementEvent {
  final int id;
  const UpdateToDoItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteToDoItemEvent extends TaskManagementEvent {
  final int id;
  const DeleteToDoItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddToDoItemEvent extends TaskManagementEvent {
  final String toDo;
  final bool completed;
  final int userId;
  const AddToDoItemEvent(
      {required this.completed, required this.toDo, required this.userId});
  @override
  List<Object?> get props => [toDo, userId, completed];
}
