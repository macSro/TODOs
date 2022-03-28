import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab2/constants.dart';
import 'package:lab2/screens/create_task_screen.dart';
import 'package:lab2/screens/home/home_task_list.dart';

import '../../bloc/tasks_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(appTitle),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTaskScreen(
                        tasks: state.tasks,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: HomeTaskList(tasks: state.tasks),
          );
        } else {
          return Scaffold(
              appBar: AppBar(title: const Text(appTitle)),
              body: const Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
