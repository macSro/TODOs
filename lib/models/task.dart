import 'package:enum_to_string/enum_to_string.dart';

import '../constants.dart';

class Task {
  final String title;
  final String description;
  final TaskType type;
  final TaskStatus status;
  final DateTime dueDate;

  Task({
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.dueDate,
  });

  Task.fromJson(Map<String, dynamic> json)
      : title = json[taskTitleJsonKey],
        description = json[taskDescriptionJsonKey],
        type = EnumToString.fromString(
          TaskType.values,
          json[taskTypeJsonKey],
        )!,
        status = EnumToString.fromString(
          TaskStatus.values,
          json[taskStatusJsonKey],
        )!,
        dueDate = DateTime.parse(json[taskDueDateJsonKey]);

  Map<String, dynamic> toJson() => {
        taskTitleJsonKey: title,
        taskDescriptionJsonKey: description,
        taskTypeJsonKey: EnumToString.convertToString(type),
        taskStatusJsonKey: EnumToString.convertToString(status),
        taskDueDateJsonKey: dueDate.toIso8601String(),
      };

  Task copyWith({
    String? title,
    String? description,
    TaskType? type,
    TaskStatus? status,
    DateTime? dueDate,
  }) =>
      Task(
        title: title ?? this.title,
        description: description ?? this.description,
        type: type ?? this.type,
        status: status ?? this.status,
        dueDate: dueDate ?? this.dueDate,
      );
}

enum TaskType { todo, email, phone, meeting }
enum TaskStatus { done, undone }
