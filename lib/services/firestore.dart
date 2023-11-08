import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');
  Future<void> addTask(Task task) {
    return FirebaseFirestore.instance.collection('tasks').add(
      {
        'taskTitle': task.title.toString(),
        'taskDesc': task.description.toString(),
        'taskCategory': task.category.toString(),
         'isCompleted':  false,
      },
    );
  }

  Stream<QuerySnapshot> getTasks() {
    final taskStream = tasks.snapshots();
    return taskStream;
  }
  Future<void> deleteTaskByTitle(String taskTitle) async {
    QuerySnapshot querySnapshot = await tasks.where('taskTitle', isEqualTo: taskTitle).get();
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

  Future<void> updateTaskByTitle(String title, Task updatedTask) {
  return FirebaseFirestore.instance.collection('tasks').where('taskTitle', isEqualTo: title).get().then((querySnapshot) {
    querySnapshot.docs.forEach((document) {
      document.reference.update({
        'taskTitle': updatedTask.title.toString(),
        'taskDesc': updatedTask.description.toString(),
        'taskCategory': updatedTask.category.toString(),
        'isCompleted': updatedTask.isCompleted,
      });
    });
  });
}
 

  
}
