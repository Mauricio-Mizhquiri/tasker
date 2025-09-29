import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task.controller.dart';
import '../widgets/task_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GeoTasker')),
      body: Obx(() {
        if (controller.loading.value) return const Center(child: CircularProgressIndicator());
        if (controller.tasks.isEmpty) return const Center(child: Text('No tasks yet'));
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (_, i) => TaskCard(task: controller.tasks[i], index: i),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/task_form'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
