import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tasks_bloc.dart';
import '../models/task.dart';
import '../tools.dart';

class CreateTaskScreen extends StatefulWidget {
  final List<Task> tasks;
  const CreateTaskScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;
  int _typeId = TaskType.todo.index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('New task'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: _validator,
                  maxLength: 30,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  validator: _validator,
                  maxLength: 255,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 10),
                    ).then((value) {
                      setState(() {
                        _dueDate = value;
                      });
                    });
                  },
                  child: const Text('Select the due date'),
                ),
                const SizedBox(height: 16),
                if (_dueDate == null)
                  const Text(
                    'Due date not selected!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                if (_dueDate != null)
                  Text(
                    'Selected: ${Tools.parseDate(_dueDate!)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                const SizedBox(height: 32),
                const Text(
                  'Task type:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: TaskType.values
                      .map((type) => RadioListTile(
                            title: Text(EnumToString.convertToString(type)),
                            groupValue: _typeId,
                            value: type.index,
                            onChanged: (value) {
                              setState(() {
                                _typeId = type.index;
                              });
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submit(),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value!.isEmpty) {
      return 'Enter the value.';
    }
    return null;
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final title = _titleController.text;
      final description = _descriptionController.text;

      BlocProvider.of<TasksBloc>(context).add(
        AddTask(
          newTask: Task(
              title: title,
              description: description,
              type: TaskType.values.elementAt(_typeId),
              status: TaskStatus.undone,
              dueDate: _dueDate!),
          oldTasks: widget.tasks,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
