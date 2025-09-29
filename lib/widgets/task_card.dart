import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task.model.dart';
import '../controllers/task.controller.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskCard({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    return Card(
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.done ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: task.description != null ? Text(task.description!) : null,
        leading: Checkbox(
          value: task.done,
          onChanged: (_) => controller.toggleTask(index),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () => controller.removeTask(index),
        ),
        onTap: () => Get.toNamed('/task_detail/${task.id}'),
      ),
    );
  }
}
