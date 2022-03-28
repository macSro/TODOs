import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../tools.dart';

class TaskScreen extends StatelessWidget {
  final Task task;

  const TaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Due: ${Tools.parseDate(task.dueDate)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Spacer(),
                Text(
                  'Status: ${EnumToString.convertToString(task.status)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
