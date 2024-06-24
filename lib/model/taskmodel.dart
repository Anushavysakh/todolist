import 'package:uuid/uuid.dart';

class TaskModel {
  String? id ;
  String? title;
  String? description;
  bool isDone;


  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isDone = false,
  }) {
    id ??= Uuid().v4();
  }
  //
  // factory TaskModel.fromJson(Map<String, dynamic> json) {
  //   return TaskModel(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     isDone: json['isDone'],
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'isDone': isDone,
  //   };
  // }
}
