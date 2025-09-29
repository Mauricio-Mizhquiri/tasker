import 'package:flutter/material.dart';
import 'package:geo_tasker/controllers/task.controller.dart';
import 'package:geo_tasker/services/db.service.dart';
import 'package:geo_tasker/services/llm.service.dart';
import 'package:geo_tasker/services/media.service.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'core/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicialización de la DB
  final dbService = DbService();
  await dbService.init();
  // Registra servicios
  Get.put(dbService);
  Get.put(LlmService());
  Get.put(MediaService());
  Get.put(TaskController()); //controlador principal
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GeoTasker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: routes,
    );
  }
}
