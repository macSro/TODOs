import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lab2/screens/create_task_screen.dart';
import 'package:lab2/screens/task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateTaskScreen(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                child: Slidable(
                  startActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        label: 'Remove',
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        onPressed: (context) => {},
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        label: 'Done',
                        icon: Icons.done,
                        backgroundColor: Colors.blue,
                        onPressed: (context) => {},
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskScreen(),
                      ),
                    ),
                    leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(
                        Icons.task,
                        //Icons.email,
                        //Icons.call,
                        //Icons.videocam,
                        color: Colors.blue,
                      ),
                    ),
                    title: const Text('title'),
                    subtitle: const Text('due date'),
                    trailing: const Text('status'),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
