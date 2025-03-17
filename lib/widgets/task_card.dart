import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../ui/add_edit_task.dart';
import 'audio_player_widget.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTaskScreen(task: task),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  _buildStatusDropdown(context),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _PriorityBadge(priority: task.priority),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(task.dueDate),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              if (task.attachmentPath != null) ...[
                const SizedBox(height: 8),
                Image.file(
                  File(task.attachmentPath!),
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
              if (task.audioPath != null) ...[
                const SizedBox(height: 8),
                const Divider(),
                AudioPlayerWidget(audioPath: task.audioPath!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown(BuildContext context) {
    return DropdownButton<TaskStatus>(
      value: task.status,
      onChanged: (TaskStatus? newStatus) {
        if (newStatus != null) {
          context.read<TaskProvider>().updateTaskStatus(task.id, newStatus);
        }
      },
      items: TaskStatus.values.map((status) {
        return DropdownMenuItem(
          value: status,
          child: Text(_getStatusText(status)),
        );
      }).toList(),
    );
  }

  String _getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _PriorityBadge extends StatelessWidget {
  final TaskPriority priority;

  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _getPriorityColor().withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flag_rounded,
            size: 16,
            color: _getPriorityColor(),
          ),
          const SizedBox(width: 4),
          Text(
            _getPriorityText(),
            style: TextStyle(
              color: _getPriorityColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor() {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }

  String _getPriorityText() {
    switch (priority) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }
}