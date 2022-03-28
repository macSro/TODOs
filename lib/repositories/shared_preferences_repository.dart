import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/task.dart';

class SharedPreferencesRepository {
  Future<List<Task>> loadTasks() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? results = sharedPreferences.getStringList(loadTasksJsonKey);
    if (results == null) {
      return List<Task>.empty(growable: true);
    } else {
      return results
          .map((jsonTask) => Task.fromJson(jsonDecode(jsonTask)))
          .toList();
    }
  }

  Future<bool> saveTasks(List<Task> tasks) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setStringList(
      loadTasksJsonKey,
      tasks.map((task) => jsonEncode(task)).toList(),
    );
  }
}
