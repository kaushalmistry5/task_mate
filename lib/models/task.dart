import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Task{
  final int? taskId;
  final String title;
  final String date;
  final String taskDes;

  Task({
    this.taskId,
    required this.title,
    required this.date,
    required this.taskDes,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'title': title,
      'date': date,
      'task_des': taskDes,
    };
  }
  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      taskId: map['taskId']?.toInt() ?? 0,
      title: map['title']?? '',
      date: map['date']?? '',
      taskDes: map['task_des']?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}