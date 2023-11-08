import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  TasksList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  /*
  Widget build(BuildContext context) {
  return ListView.builder(
      itemCount: tasks.length,
itemBuilder: (ctx, index) => TaskItem((tasks[index]),
    ));
  }*/
 Widget build(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: firestoreService.getTasks(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final taskLists = snapshot.data!.docs;
        List<Task> taskItems = [];

        for (int index = 0; index < taskLists.length; index++) {
          DocumentSnapshot document = taskLists[index];
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String title = data['taskTitle'] ?? ''; // Handle potential null value
          String description = data['taskDesc'] ?? ''; // Handle potential null value
         DateTime date;
if (data['taskDate'] != null) {
  date = DateTime.parse(data['taskDate']);
} else {
  date = DateTime.now(); // Utilisez la date actuelle comme valeur par défaut
} // Handle potential null value
          String categoryString = data['taskCategory'] ?? 'others'; // Handle potential null value

          Category category;
          switch (categoryString) {
            case 'personal':
              category = Category.personal;
              break;
            case 'work':
              category = Category.work;
              break;
            case 'shopping':
              category = Category.shopping;
              break;
            default:
              category = Category.others;
          }
          Task task = Task(
            title: title,
            description: description,
            date: date,
            category: category,
          );
          taskItems.add(task);
        }

        return ListView.builder(
          itemCount: taskItems.length,
          itemBuilder: (ctx, index) {
            return TaskItem(taskItems[index]);
          },
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
      }
    },
  );
}


}
