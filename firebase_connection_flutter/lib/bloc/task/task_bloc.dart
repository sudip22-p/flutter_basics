import 'package:firebase_connection_flutter/models/task.dart';
import 'package:firebase_connection_flutter/services/firestore_task_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FirestoreTaskService firestoreService;

  TaskBloc({required this.firestoreService}) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<NewTaskAdded>(_onNewTaskAdded);
    on<TaskCompleted>(_onTaskCompleted);
    on<TaskDeleted>(_onTaskDeleted);
  }
  @override
  void onChange(Change<TaskState> change) {
    super.onChange(change);
    print('auth bloc change - $change');
  }

  @override
  void onTransition(Transition<TaskEvent, TaskState> transition) {
    super.onTransition(transition);
    print("sud transition- $transition");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("sud error- $error");
    print("sud stack trace- $stackTrace");
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      await for (var tasks in firestoreService.getTasksStream(event.uid)) {
        emit(TaskLoaded(tasks));
        print("sud - tasks loaded in await for");
      }
    } catch (e) {
      print("sud - caught in await for: $e");
      emit(TaskFailure(errorMessage: e.toString()));
    }
  }

  void _onNewTaskAdded(NewTaskAdded event, Emitter<TaskState> emit) async {
    try {
      await firestoreService.addTask(event.name, event.uid);
    } catch (e) {
      emit(TaskFailure(errorMessage: e.toString()));
    }
  }

  void _onTaskCompleted(TaskCompleted event, Emitter<TaskState> emit) async {
    try {
      await firestoreService.toggleTask(event.taskId, event.isCompleted);
    } catch (e) {
      emit(TaskFailure(errorMessage: e.toString()));
    }
  }

  void _onTaskDeleted(TaskDeleted event, Emitter<TaskState> emit) async {
    try {
      await firestoreService.deleteTask(event.taskId);
    } catch (e) {
      emit(TaskFailure(errorMessage: e.toString()));
    }
  }
}
