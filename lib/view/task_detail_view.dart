import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task.controller.dart';

class TaskDetailView extends StatelessWidget {
  TaskDetailView({super.key});
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id'];
    final task = controller.tasks.firstWhere((t) => t.id == id);

    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (task.description != null) Text(task.description!),
            if (task.photoPath != null) ...[
              const SizedBox(height: 16),
              Image.file(File(task.photoPath!)),
            ],
            if (task.audioPath != null) ...[
              const SizedBox(height: 16),
              Text('Audio recorded at: ${task.audioPath}'),
            ],
            const SizedBox(height: 16),
            CheckboxListTile(
              value: task.done,
              onChanged: (_) {
                final index = controller.tasks.indexOf(task);
                controller.toggleTask(index);
              },
              title: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
