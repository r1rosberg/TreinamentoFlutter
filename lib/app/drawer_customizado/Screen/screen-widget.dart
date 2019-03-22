import 'package:flutter/material.dart';

class ScreenWidget extends StatefulWidget {
  final Function onTap;

  ScreenWidget({Key key, this.onTap}):super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Care'),
        leading: GestureDetector(
          onTap: widget.onTap,
          child: Icon(Icons.menu),
          ),
        ),
      body: Center(
        child: Text('Tela Inicial'),
      ),
    );
  }
}