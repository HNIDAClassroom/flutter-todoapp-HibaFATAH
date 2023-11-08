import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { personal, work, shopping, others }

class Task {
  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
     this.isCompleted = false,

  }) : id = uuid.v4();

  final String id;
  late final String title;
  late final String description;
  late final DateTime date;
  late final Category category;
  bool isCompleted;
}
// 