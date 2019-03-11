import 'package:flutter/material.dart';

import './app/main_ControlePessoa_ex1.dart';
import './app/main_CauculadoraIMC_ex2.dart';
import './app/conversor_de_moedas/conversor.dart';

import './app/main_LstInfFavorito_ex01.dart';
import './app/main_ListaInfinita_ex02.dart';

main() {
  runApp(MaterialApp(
    title: 'Programas Curso Flutter.',
    home: Teste(),
    theme: ThemeData(),
  ));
}

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercícios Flutter'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text('Lista Infivita Favorito', style: TextStyle(color: Colors.white, fontSize: 20.0),),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LstInfFavorito_ex01()));
              },
            ),
            RaisedButton(
              child: Text('Lista Infivita', style: TextStyle(color: Colors.white, fontSize: 20.0),),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ListaInfinita_ex02()));
              },
            ),
            RaisedButton(
              child: Text('Controle Pessoa', style: TextStyle(color: Colors.white, fontSize: 20.0),),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyAppControlePessoa()));
              },
            ),
            RaisedButton(
              child: Text('Calcular IMC', style: TextStyle(color: Colors.white, fontSize: 20.0),),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CalculadoraImc()));
              },
            ),
            RaisedButton(
              child: Text('Conversor De Moedas', style: TextStyle(color: Colors.white, fontSize: 20.0),),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Conversor()));
              },
            )
          ],
        ),
      ),
    );
  }
}
