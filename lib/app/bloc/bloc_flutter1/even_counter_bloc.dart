import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class EvenCounterBloc {
  int _counter = 0;

  final _counter$ = BehaviorSubject<int>.seeded(0);

  //final _incrementController = StreamController<int>();

  EvenCounterBloc() {
    /*_incrementController.stream.listen((_){
      _counter = _counter + 2;
      _counter$.add(_counter); 
    });*/
  }

  //Sink<void> get increment => _incrementController.sink;

  void increment() {
    _counter = _counter + 2;
    _counter$.add(_counter);
  }

  Stream<int> get counter$ => _counter$.stream;

  void dispose() {
    //_incrementController.close();
    _counter$.close();
  }
}
