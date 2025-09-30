import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.model.dart';
import 'package:uuid/uuid.dart';

class DbService {
  late Database db;

  Future<void> init() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        //create table
        await db.execute(''' 
          CREATE TABLE tasks(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            lat REAL,
            lng REAL,
            photoPath TEXT,
            audioPath TEXT,
            done INTEGER,
            createdAt TEXT,
            synced INTEGER
          )
        ''');
      },
    );
  }
  
//obtner todos los task
  Future<List<TaskModel>> getAll() async {
    final rows = await db.query('tasks', orderBy: 'createdAt DESC');
    return rows.map((m) => TaskModel(
      id: m['id'] as String,
      title: m['title'] as String,
      description: m['description'] as String?,
      lat: m['lat'] as double?,
      lng: m['lng'] as double?,
      photoPath: m['photoPath'] as String?,
      audioPath: m['audioPath'] as String?,
      done: (m['done'] as int) == 1,
      createdAt: DateTime.parse(m['createdAt'] as String),
      synced: (m['synced'] as int) == 1,
    )).toList();
  }

  Future<void> insert(TaskModel t) async {
    //insertar a la bd un task
    await db.insert('tasks', {
      'id': t.id.isEmpty ? const Uuid().v4() : t.id,
      'title': t.title,
      'description': t.description,
      'lat': t.lat,
      'lng': t.lng,
      'photoPath': t.photoPath,
      'audioPath': t.audioPath,
      'done': t.done ? 1 : 0,
      'createdAt': t.createdAt.toIso8601String(),
      'synced': t.synced ? 1 : 0,
    });
  }

//modificar el task
  Future<void> update(TaskModel t) async {
    await db.update('tasks', {
      'title': t.title,
      'description': t.description,
      'lat': t.lat,
      'lng': t.lng,
      'photoPath': t.photoPath,
      'audioPath': t.audioPath,
      'done': t.done ? 1 : 0,
      'synced': t.synced ? 1 : 0,
    }, where: 'id=?', whereArgs: [t.id]);
  }

//eliminar task
  Future<void> deleteTask(String id) async {
    await db.delete('tasks', where: 'id=?', whereArgs: [id]);
  }
}
