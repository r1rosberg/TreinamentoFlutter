import 'package:flutter/material.dart';
import './task.dart';

class TaskRow extends StatelessWidget {
  final Task task;
  final double dotSize = 12.0;
  final Animation<double> animation;

  const TaskRow({Key key, this.task, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0 - (dotSize / 2)),
                child: Container(
                  height: dotSize,
                  width: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: task.color,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      task.name,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      task.category,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Text(
                  task.time,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
