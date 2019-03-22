import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CounterBloc {
  int _counter = 0;

  final _counter$ = BehaviorSubject<int>.seeded(0);

  final _incrementController = StreamController<int>();

  CounterBloc() {
   _incrementController.stream.listen((_){
      _counter ++;
      _counter$.add(_counter); 
    });
  }

  Sink<void> get increment => _incrementController.sink;

  Stream<int> get counter$ => _counter$.stream;

  void dispose() {
    _incrementController.close();
    _counter$.close();
  }
  
}