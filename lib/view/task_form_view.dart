import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geo_tasker/services/llm.service.dart';
import 'package:get/get.dart';
import '../controllers/task.controller.dart';
import '../services/media.service.dart';
import '../models/task.model.dart';
import 'package:uuid/uuid.dart';

class TaskFormView extends StatefulWidget {
  const TaskFormView({super.key});
  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final controller = Get.find<TaskController>();
  final media = Get.find<MediaService>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  File? photo;

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 8),
            if (photo != null) Image.file(photo!, height: 150),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final file = await media.takePhoto();
                    if (file != null) setState(() => photo = file);
                  },
                  child: const Text('Camera'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final file = await media.pickImage();
                    if (file != null) setState(() => photo = file);
                  },
                  child: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            ElevatedButton(
  onPressed: () async {
    if (titleCtrl.text.isEmpty) return;

    // Llamar a LLM para resumir la descripción
    final llm = Get.find<LlmService>();
    String? summarizedDescription;
    if (descCtrl.text.isNotEmpty) {
      summarizedDescription = await llm.summarize(descCtrl.text);
      // Si falla la LLM, usamos el texto original
      summarizedDescription ??= descCtrl.text;
    }

    final task = TaskModel(
      id: const Uuid().v4(),
      title: titleCtrl.text,
      description: summarizedDescription ?? '',
      photoPath: photo?.path,
    );

    try {
      await controller.addTask(task);
      print("Task added, closing window...");
      Get.back(); // cierra la ventana
    } catch (e) {
      print("Error adding task: $e");
    }
  },
  child: const Text('Save Task'),
),

            

          ],
        ),
      ),
    );
  }
}
