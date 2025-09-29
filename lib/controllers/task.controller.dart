import 'package:get/get.dart';
import '../models/task.model.dart';
import '../services/db.service.dart';
import '../services/llm.service.dart';
import '../services/media.service.dart';

class TaskController extends GetxController {
  final tasks = <TaskModel>[].obs;
  final loading = false.obs;

  final DbService db = Get.find();
  final LlmService llm = Get.find();
  final MediaService media = Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadInitialTasks(); //carga tareas
  }

  Future<void> _loadInitialTasks() async {
    loading.value = true;
    try {
      final list = await db.getAll();
      tasks.assignAll(list);
    } catch (e) {
      print("Error loading tasks: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> addTask(TaskModel task) async {
    await db.insert(task);
    tasks.insert(0, task);
  }

  Future<void> toggleTask(int index) async {
    final t = tasks[index];
    final updated = t.copyWith(done: !t.done);
    tasks[index] = updated;
    await db.update(updated);
  }

  Future<void> removeTask(int index) async {
    final t = tasks.removeAt(index);
    await db.deleteTask(t.id);
  }
}
