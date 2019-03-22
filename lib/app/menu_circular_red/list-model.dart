import 'package:flutter/material.dart';
import './task.dart';
import './task-row.dart';

class ListModel {
  final GlobalKey<AnimatedListState> listkey;
  final List<Task> items;

  ListModel({Key key, this.listkey, this.items});

  AnimatedListState get _animatedList => listkey.currentState;

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedList.insertItem(index, duration: Duration(milliseconds: 350));
  }

  Task removeAt(int index) {
    final Task removedItem = items[index];
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (context, animation) => TaskRow(
          task: removedItem,
          animation: animation,
        ),
        duration: Duration(milliseconds: (350 + 350 * (index/length)).toInt())
      );
    }
    return removedItem;
  }

  int get length => items.length;
  Task operator [](int index) {
    print('index : $index, item: ${items[index].name}' );
    return items[index];
  }
  int indexOf(Task item) => items.indexOf(item);
}
