import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.model.dart';

class FirestoreService {
  final CollectionReference tasksRef =
      FirebaseFirestore.instance.collection('tasks');

  /// Agrega una tarea
  Future<void> addTask(TaskModel task) async {
    await tasksRef.doc(task.id).set(task.toFirestore());
  }

  /// Actualiza una tarea
  Future<void> updateTask(TaskModel task) async {
    await tasksRef.doc(task.id).update(task.toFirestore());
  }

  /// Elimina una tarea por id
  Future<void> deleteTask(String id) async {
    await tasksRef.doc(id).delete();
  }

  /// Obtiene todas las tareas
  Future<List<TaskModel>> getAllTasks() async {
    final snapshot = await tasksRef.get();
    return snapshot.docs
        .map((doc) => TaskModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
