part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class LoadTasks extends TasksEvent {}

class SaveTasks extends TasksEvent {
  final List<Task> tasks;

  SaveTasks(this.tasks);
}

class AddTask extends TasksEvent {
  final Task newTask;
  final List<Task> oldTasks;

  AddTask({
    required this.newTask,
    required this.oldTasks,
  });
}

class DeleteTask extends TasksEvent {
  final Task task;
  final List<Task> oldTasks;

  DeleteTask({
    required this.task,
    required this.oldTasks,
  });
}

class UpdateTask extends TasksEvent {
  final Task task;
  final List<Task> oldTasks;

  UpdateTask({
    required this.task,
    required this.oldTasks,
  });
}
