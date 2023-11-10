import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate; // Utilisez DateTime? pour gérer une date potentielle
  Category _selectedCategory = Category.personal;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    if (_selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Merci de sélectionner une date pour la tâche'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddTask(Task(
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate!, // Utilisez ! pour accéder à la valeur non nulle
      category: _selectedCategory,
    isCompleted:false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task title',
            ),
          ),
          SizedBox(height: 5,),
          TextField(
            controller: _descriptionController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task description',
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate; // Assurez-vous que _selectedDate est mis à jour
                });
              }
            },
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                Text('Date sélectionnée: ${_selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : "Non sélectionnée"}'),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              DropdownButton<Category>(
                value: _selectedCategory,
                style: TextStyle(color: Color.fromARGB(255, 12, 12, 12)),
                items: Category.values
                    .map((category) => DropdownMenuItem<Category>(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ), SizedBox(width: 10,),
              ElevatedButton(
                onPressed: () {
                  _submitTaskData();
                  print(_titleController.text);
                },
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
