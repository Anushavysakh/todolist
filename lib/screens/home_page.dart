import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/task_provider.dart';
import 'package:todolist/screens/add_task_screen.dart';
import 'package:todolist/screens/view_task_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDone = false;
  SlidableController? slidableController;
  String formattedDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddTaskScreen(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, TaskProvider tasks, child) {
          return tasks.tasks.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.tasks.length,
                  itemBuilder: (ctx, index) {
                    final task = tasks.tasks[index];
                    return InkWell(
                      child: Slidable(
                        controller: slidableController,
                        startActionPane:
                            ActionPane(
                                motion: const StretchMotion(), children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(20),
                            backgroundColor: Colors.red,

                            icon: Icons.delete,
                            onPressed: (context) {
                              Provider.of<TaskProvider>(context, listen: false)
                                  .deleteTask(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("${task.title} deleted"),
                                      ),
                                    );
                            },
                          )
                        ]),


                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.orange.shade700,
                          ),
                          padding: const EdgeInsets.only(left: 18, top: 10),
                          margin: const EdgeInsets.all(12),
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
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .toggleCheckbox(task);
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
                )
              : const Center(
                  child: Text("No Tasks Added"),
                );
        },
      ),
    );
  }
}
