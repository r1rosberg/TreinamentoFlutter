//https://github.com/davidanaya/flutter-counter-bloc
//https://medium.com/@danaya/multiple-blocs-in-flutter-and-how-to-communicate-between-them-e441282dc62a

import 'package:flutter/material.dart';

import './app_bloc.dart';
import './bloc_provider.dart';

class BlocFlutter1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc();
    return BlocProvider(bloc: appBloc, child: _MyHomePage());
  }
}

class _MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).counterBloc;
    final evenBloc = BlocProvider.of(context).evenCounterBloc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Provider Origem'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder(
            stream: evenBloc.counter$,
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? Text('${snapshot.data}',
                      style: Theme.of(context).textTheme.display1)
                  : CircularProgressIndicator();
            },
          ),
          StreamBuilder(
            stream: bloc.counter$,
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? Text('${snapshot.data}',
                      style: Theme.of(context).textTheme.display1)
                  : CircularProgressIndicator();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.increment.add(null);
          evenBloc.increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.ac_unit),
      ),
    );
  }
}
