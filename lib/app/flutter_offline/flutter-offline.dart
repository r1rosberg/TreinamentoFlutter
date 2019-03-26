//https://github.com/jogboms/flutter_offline

import 'package:flutter/material.dart';

import 'package:flutter_offline/flutter_offline.dart';

class FlutterOffline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Demo'),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Colors.green : Colors.black,
                  child: Center(
                    child: Text('${connected ? "Online" : "Offline"}'),
                  ),
                ),
              ),
              Center(
                child: Text('Yay!'),
              ),
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Não há botão para precionar....'),
            Text('Basta desligar a internet..'),
          ],
        ),
      ),
    );
  }
}
