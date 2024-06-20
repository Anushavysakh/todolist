import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/taskmodel.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];

  List<TaskModel> get tasks {
    return [..._taskList];
  }

  addNote(TaskModel task) {
    _taskList.add(task);
    notifyListeners();
  }

  void editTask(TaskModel task) {
    int index = _taskList.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _taskList[index] = task;
      notifyListeners();
    }
  }

  void deleteTask(int id) {
    _taskList.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  toggleDone(int index) {
    _taskList[index].isDone = !_taskList[index].isDone;
    notifyListeners();
  }
}
