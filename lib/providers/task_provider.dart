import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  // Getters for filtered tasks
  List<Task> get allTasks => _tasks;

  List<Task> get pendingTasks => _tasks
      .where((task) => task.status == TaskStatus.pending)
      .toList();

  List<Task> get inProgressTasks => _tasks
      .where((task) => task.status == TaskStatus.inProgress)
      .toList();

  List<Task> get completedTasks => _tasks
      .where((task) => task.status == TaskStatus.completed)
      .toList();

  // Add new task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Update existing task
  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  // Delete task
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  // Update task status
  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  // Initialize with dummy data
  void initializeDummyData() {
    _tasks = [
      Task(
        id: '1',
        title: 'Design User Interface',
        description: 'Create wireframes and mockups for the new mobile app',
        dueDate: DateTime.now().add(const Duration(days: 3)),
        priority: TaskPriority.high,
      ),
      Task(
        id: '2',
        title: 'Implement Authentication',
        description: 'Add user login and registration functionality',
        dueDate: DateTime.now().add(const Duration(days: 5)),
        status: TaskStatus.inProgress,
        priority: TaskPriority.medium,
      ),
      Task(
        id: '3',
        title: 'Write Documentation',
        description: 'Document the API endpoints and usage guidelines',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        status: TaskStatus.completed,
        priority: TaskPriority.low,
      ),
    ];
    notifyListeners();
  }
}