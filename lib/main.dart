import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab2/bloc/tasks_bloc.dart';
import 'package:lab2/repositories/shared_preferences_repository.dart';

import 'constants.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SharedPreferencesRepository(),
      child: BlocProvider(
        create: (context) => TasksBloc(
          RepositoryProvider.of<SharedPreferencesRepository>(context),
        )..add(LoadTasks()),
        child: MaterialApp(
          title: appTitle,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
