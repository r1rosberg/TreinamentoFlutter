import 'package:flutter/material.dart';

class Task {
  final String name;
  final String category;
  final String time;
  final Color color;
  final bool completed;

  Task({this.name, this.category, this.time, this.color, this.completed});

  @override
  String toString() {
    return 'name: $name, category: $category, time: $time, color: $color, completed: $completed';
  }
}
