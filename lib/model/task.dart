import 'dart:convert';
enum Priority {low,medium,high}
class Task{
  String id;
  String title;
  String? description;
  DateTime? due;
  Priority priority;
  bool completed;
Task({
  required this.id,
  required this.title,
  this.description,
  this.due,
  this.priority=Priority.medium,
  this.completed=false
  });


factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      due: json['due'] != null ? DateTime.parse(json['due']) : null,
      priority: Priority.values[json['priority']],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'due': due?.toIso8601String(),
        'priority': priority.index,
        'completed': completed,
      };

  static String encodeList(List<Task> tasks) =>
      jsonEncode(tasks.map((t) => t.toJson()).toList());

  static List<Task> decodeList(String jsonString) {
    final data = jsonDecode(jsonString) as List;
    return data.map((e) => Task.fromJson(e)).toList();
  }
}
































