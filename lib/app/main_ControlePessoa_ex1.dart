//_ControlePessoa_ex1
import 'package:flutter/material.dart';

//void MyAppControlePessoa() => runApp(MyApp());

class MyAppControlePessoa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home(); /* MaterialApp(
      title: 'Oá Flutter', 
      theme: ThemeData(), 
      home: Home());*/
  }
}

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  int _pessoas = 0;
  String _entrada = "Podem entrar...";

  void _ctrlPessoas(int delta) {
    setState(() {
      _pessoas += delta;
      if (_pessoas > 10) {
        _entrada = "Lotado...";
      } else if (_pessoas < 0) {
        _entrada = "Mundo estranho ;-)";
      } else {
        _entrada = "Podem entrar...";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcuclar Pessoas'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarOpacity: 1,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/restaurante.jpg',
            fit: BoxFit.cover,
            height: 1000.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Pessoas $_pessoas",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _ctrlPessoas(1);
                    },
                    child: Text(
                      "+1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _ctrlPessoas(-1);
                    },
                    child: Text(
                      "-1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              Text(_entrada,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
