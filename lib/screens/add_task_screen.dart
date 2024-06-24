import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/model/taskmodel.dart';
import 'package:todolist/providers/task_provider.dart';

import '../widgets/note_textfield.dart';
class AddTaskScreen extends StatelessWidget {
   AddTaskScreen({super.key});

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Add Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            addNoteTextField(titleController, 'Title'),
            const SizedBox(
              height: 10,
            ),
            addNoteTextField(descriptionController, 'Description'),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fields cannot be empty'),
                    ),
                  );
                  return;
                }
                TaskModel note = TaskModel(description: descriptionController.text,title: titleController.text,);
                Provider.of<TaskProvider>(context,listen: false).addNote(note);
                Navigator.of(context).pop();
              },
              child: Text('ADD'),
            )
          ],
        ),
      ),
    );
  }

  addNoteTextField(TextEditingController controller, String hint) {
    return NoteTextfield(controller,hint);
  }
}

