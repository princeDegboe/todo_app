import 'package:intl/intl.dart';

enum Priority { medium, low, high }

final formatter = DateFormat.yMd();

class Todo {
  late int localID;

  final String id;
  final String description;
  final String title;
  final dynamic beginedAt;
  final dynamic finishedAt;
  final DateTime deadlineAt;
  final String priority;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    required this.id,
    required this.description,
    required this.title,
    required this.beginedAt,
    required this.finishedAt,
    required this.deadlineAt,
    required this.priority,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  static Todo fromMap(Map<dynamic, dynamic> map) {
    return Todo(
      id: map["id"],
      description: map["description"],
      title: map["title"],
      beginedAt: map["begined_at"],
      finishedAt: map["finished_at"],
      deadlineAt: DateTime.parse(map["deadline_at"]),
      priority: map["priority"],
      userId: map["user_id"],
      createdAt: DateTime.parse(map["created_at"]),
      updatedAt: DateTime.parse(map["updated_at"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "title": title,
        "begined_at": beginedAt,
        "finished_at": finishedAt,
        "deadline_at": deadlineAt.toIso8601String(),
        "priority": priority,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
