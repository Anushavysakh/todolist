import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/taskmodel.dart';
import '../providers/task_provider.dart';
import '../widgets/textfield_decoration.dart';

class ViewTaskScreen extends StatelessWidget {
  final int index;

  ViewTaskScreen(this.index, {super.key});

  String? title;
  String? des;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    var task = taskProvider.tasks[index];

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        var task = taskProvider.tasks[index];
        return Scaffold(
            backgroundColor: Colors.orangeAccent.shade100,
            appBar: AppBar(backgroundColor: Colors.orange, actions: [
              IconButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      TaskModel updatedTask = TaskModel(
                          id: task.id,
                          title: title ?? task.title,
                          description: des ?? task.description,
                          isDone: task.isDone);
                      taskProvider.editTask(updatedTask);
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.save_rounded)),
            ]),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: buildInputDecoration('Title'),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontStyle: FontStyle.italic),
                        initialValue: task.title,
                        enabled: true,
                        onChanged: (val) {
                          title = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                        ),
                        child: TextFormField(
                          decoration: buildInputDecoration('Description'),
                          initialValue: task.description,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                          enabled: true,
                          onChanged: (val) {
                            des = val;
                          },
                          validator: (value) => buildValidator(value!),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Mark as done'),
                            Checkbox(
                              value: task.isDone,
                              onChanged: (value) {
                                taskProvider.toggleCheckbox(task);
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ));
      },
    );
  }
}
