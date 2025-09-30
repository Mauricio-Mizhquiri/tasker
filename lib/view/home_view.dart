import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task.controller.dart';
import '../controllers/theme.controller.dart'; // 👈 IMPORTA AQUÍ
import '../widgets/task_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoTasker'),
        actions: [
          IconButton(
            icon: Obx(() {
              final themeCtrl = Get.find<ThemeController>();
              return Icon(
                themeCtrl.isDark.value ? Icons.dark_mode : Icons.light_mode,
              );
            }),
            onPressed: () {
              Get.find<ThemeController>().toggleTheme();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.tasks.isEmpty) {
          return const Center(child: Text('No tasks yet'));
        }
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
