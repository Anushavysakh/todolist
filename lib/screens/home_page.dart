import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/task_provider.dart';
import 'package:todolist/screens/add_task_screen.dart';
import 'package:todolist/screens/view_task_screen.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TaskProvider>(context).tasks;
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  AddTaskScreen(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          final task = tasks[index];

          return InkWell(
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                Provider.of<TaskProvider>(context, listen: false)
                    .deleteTask(index);
              },
              child: AnimatedContainer(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.orange.shade700,
                ),
                padding: const EdgeInsets.only(left: 18, top: 10),
                margin: const EdgeInsets.all(12),
                duration: Durations.extralong3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.title!,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: task.isDone,
                      checkColor: Colors.black,
                      onChanged: (value) {
                        Provider.of<TaskProvider>(context, listen: false)
                            .toggleDone(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewTaskScreen(index),
              ));
            },
          );
        },
      ),
    );
  }
}
