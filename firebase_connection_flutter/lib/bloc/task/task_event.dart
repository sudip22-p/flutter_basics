part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTasks extends TaskEvent {
  final String uid;
  LoadTasks(this.uid);
}

class NewTaskAdded extends TaskEvent {
  final String name;
  final String uid;
  NewTaskAdded({required this.name, required this.uid});
}

class TaskCompleted extends TaskEvent {
  final String taskId;
  final bool isCompleted;
  TaskCompleted(this.taskId, this.isCompleted);
}

class TaskDeleted extends TaskEvent {
  final String taskId;
  TaskDeleted(this.taskId);
}
