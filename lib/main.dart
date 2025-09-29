import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geo_tasker/controllers/task.controller.dart';
import 'package:geo_tasker/services/db.service.dart';
import 'package:geo_tasker/services/firestore.service.dart';
import 'package:geo_tasker/services/llm.service.dart';
import 'package:geo_tasker/services/media.service.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'core/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Inicializa la DB primero
  final dbService = DbService();
  await dbService.init();

  // Registra servicios
  Get.put(dbService);
  Get.put(FirestoreService());
  Get.put(LlmService());
  Get.put(MediaService());

  // Registra controlador principal
  Get.put(TaskController());

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
