import 'package:bloc/bloc.dart';
import 'package:lab2/models/task.dart';
import 'package:meta/meta.dart';

import '../repositories/shared_preferences_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final SharedPreferencesRepository _prefs;

  TasksBloc(this._prefs) : super(TasksInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TasksLoading());
      final tasks = await _prefs.loadTasks();
      emit(TasksLoaded(tasks));
    });

    on<SaveTasks>(((event, emit) async {
      emit(TasksLoading());
      await _prefs.saveTasks(event.tasks);
      emit(TasksLoaded(event.tasks));
    }));

    on<AddTask>((event, emit) {
      event.oldTasks.add(event.newTask);
      event.oldTasks.sort((t1, t2) => t1.dueDate.compareTo(t2.dueDate));
      emit(TaskAdded());
      add(SaveTasks(event.oldTasks));
    });

    on<DeleteTask>((event, emit) {
      emit(TasksLoading());
      event.oldTasks.remove(event.task);
      add(SaveTasks(List<Task>.of(event.oldTasks)));
    });

    on<UpdateTask>((event, emit) {
      emit(TasksLoading());
      List<Task> newTasks = List<Task>.empty(growable: true);
      for (Task task in event.oldTasks) {
        if (task != event.task) {
          newTasks.add(task);
        } else {
          newTasks.add(
            task.copyWith(
                status: task.status == TaskStatus.done
                    ? TaskStatus.undone
                    : TaskStatus.done),
          );
        }
      }
      add(SaveTasks(List<Task>.of(newTasks)));
    });
  }
}
