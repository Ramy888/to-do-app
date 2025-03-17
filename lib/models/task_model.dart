import 'package:flutter/foundation.dart';

enum TaskStatus {
  pending,
  inProgress,
  completed
}

enum TaskPriority {
  low,
  medium,
  high
}

class Task {
  final String id;
  String title;
  String description;
  DateTime dueDate;
  TaskStatus status;
  TaskPriority priority;
  String? attachmentPath;
  String? audioPath;
  DateTime createdAt;
  DateTime modifiedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.medium,
    this.attachmentPath,
    this.audioPath,
    DateTime? createdAt,
    DateTime? modifiedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        modifiedAt = modifiedAt ?? DateTime.now();

  Task copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    TaskStatus? status,
    TaskPriority? priority,
    String? attachmentPath,
    String? audioPath,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      audioPath: audioPath ?? this.audioPath,
      createdAt: createdAt,
      modifiedAt: DateTime.now(),
    );
  }
}