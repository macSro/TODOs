import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lab2/bloc/tasks_bloc.dart';

import '../../models/task.dart';
import '../../tools.dart';
import '../task_screen.dart';

class HomeTaskList extends StatelessWidget {
  final List<Task> tasks;
  const HomeTaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final Task task = tasks.elementAt(index);
          return Card(
            child: InkWell(
              child: Slidable(
                startActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                        label: 'Delete',
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        onPressed: (context) {
                          BlocProvider.of<TasksBloc>(context).add(
                            DeleteTask(task: task, oldTasks: tasks),
                          );
                        }),
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      label: task.status == TaskStatus.done ? 'Undo' : 'Done',
                      icon: task.status == TaskStatus.done
                          ? Icons.undo
                          : Icons.done,
                      backgroundColor: Colors.blue,
                      onPressed: (context) {
                        BlocProvider.of<TasksBloc>(context).add(
                          UpdateTask(task: task, oldTasks: tasks),
                        );
                      },
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskScreen(task: task),
                    ),
                  ),
                  leading: SizedBox(
                    height: double.infinity,
                    child: task.type == TaskType.todo
                        ? const Icon(Icons.task, size: 32)
                        : task.type == TaskType.email
                            ? const Icon(Icons.email, size: 32)
                            : task.type == TaskType.phone
                                ? const Icon(Icons.call, size: 32)
                                : const Icon(Icons.videocam, size: 32),
                  ),
                  iconColor: Colors.blue,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Due: ${Tools.parseDate(task.dueDate)}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    EnumToString.convertToString(task.status),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
