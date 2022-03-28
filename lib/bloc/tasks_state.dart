part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class TaskAdded extends TasksState {}
