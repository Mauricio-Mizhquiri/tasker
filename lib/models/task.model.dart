class TaskModel {
  final String id;
  final String title;
  final String? description;
  final double? lat;
  final double? lng;
  final String? photoPath;
  final String? audioPath;
  final bool done;
  final DateTime createdAt;
  final bool synced;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.lat,
    this.lng,
    this.photoPath,
    this.audioPath,
    this.done = false,
    DateTime? createdAt,
    this.synced = false,
  }) : createdAt = createdAt ?? DateTime.now();

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    double? lat,
    double? lng,
    String? photoPath,
    String? audioPath,
    bool? done,
    DateTime? createdAt,
    bool? synced,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      photoPath: photoPath ?? this.photoPath,
      audioPath: audioPath ?? this.audioPath,
      done: done ?? this.done,
      createdAt: createdAt ?? this.createdAt,
      synced: synced ?? this.synced,
    );
  }

  /// Convierte a Map para Firestore
  Map<String, dynamic> toFirestore() => {
        'title': title,
        'description': description,
        'lat': lat,
        'lng': lng,
        'photoPath': photoPath,
        'audioPath': audioPath,
        'done': done,
        'createdAt': createdAt.toIso8601String(),
        'synced': synced,
      };

  /// Crea un TaskModel desde un Map de Firestore
  factory TaskModel.fromFirestore(Map<String, dynamic> map, String id) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'],
      lat: map['lat'] != null ? (map['lat'] as num).toDouble() : null,
      lng: map['lng'] != null ? (map['lng'] as num).toDouble() : null,
      photoPath: map['photoPath'],
      audioPath: map['audioPath'],
      done: map['done'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      synced: map['synced'] ?? false,
    );
  }
}
