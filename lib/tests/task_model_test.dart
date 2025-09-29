import 'package:flutter_test/flutter_test.dart';
import 'package:geo_tasker/controllers/task.controller.dart';
import 'package:geo_tasker/models/task.model.dart';

void main() {
  late TaskController controller;

  setUp(() {
    controller = TaskControllerFake();
  });

  test('Agregar tarea', () async {
    final task = TaskModel(id: '1', title: 'Prueba');
    await controller.addTask(task);
    expect(controller.tasks.length, 1);
    expect(controller.tasks.first.title, 'Prueba');
  });

  test('Toggle tarea', () async {
    final task = TaskModel(id: '1', title: 'Prueba', done: false);
    await controller.addTask(task);
    await controller.toggleTask(0);
    expect(controller.tasks.first.done, true);
  });

  test('Eliminar tarea', () async {
    final task = TaskModel(id: '1', title: 'Prueba');
    await controller.addTask(task);
    await controller.removeTask(0);
    expect(controller.tasks.isEmpty, true);
  });
}

// Controller de prueba (fake) para test en memoria
class TaskControllerFake extends TaskController {
  TaskControllerFake() {
    tasks.value = [];
  }

  @override
  Future<void> addTask(TaskModel task) async {
    tasks.add(task);
  }

  @override
  Future<void> toggleTask(int index) async {
    final t = tasks[index];
    tasks[index] = t.copyWith(done: !t.done);
  }

  @override
  Future<void> removeTask(int index) async {
    tasks.removeAt(index);
  }
}
