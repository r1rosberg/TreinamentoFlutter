import './counter_bloc.dart';
import './even_counter_bloc.dart';

class AppBloc {
  CounterBloc _counter;
  EvenCounterBloc _evenCounter;

  AppBloc()
      : _counter = CounterBloc(),
        _evenCounter = EvenCounterBloc();

  CounterBloc get counterBloc => _counter;
  EvenCounterBloc get evenCounterBloc => _evenCounter;
}
