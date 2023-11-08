import 'package:flutter/material.dart';
import 'package:todolist_app/services/firestore.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem(this.task, {Key? key}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
 // bool isCompleted ;

  @override
  void initState() {
    super.initState();
   // isCompleted = widget.task.isCompleted;
   // print("isCompleted dans initState : $isCompleted");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: widget.task.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      
                     // widget.task.isCompleted = value ?? false;
                      
                    });
                    // Mettre à jour l'état de la tâche lorsque la case à cocher est cochée ou décochée
                   // widget.task.isCompleted = isCompleted;
                    FirestoreService().updateTaskByTitle(widget.task.title, widget.task);
                    print(
                        "ID de la tâche à mettre à jour 22: ${widget.task.id}");
                    
                  },
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: widget.task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.task.description,
                        style: TextStyle(
                          decoration:
                              widget.task.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.task.date)}',
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Category:${widget.task.category.name}',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 250,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.orange),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmation"),
                          content: Text("Voulez-vous supprimer cette tâche ?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Annuler"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Supprimer"),
                              onPressed: () {
                                // Appeler la fonction de suppression ici
                                FirestoreService()
                                    .deleteTaskByTitle(widget.task.title);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
