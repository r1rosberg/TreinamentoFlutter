import 'package:flutter/material.dart';

import 'app/main_ControlePessoa_ex1.dart';
import 'app/main_CauculadoraIMC_ex2.dart';
import 'app/conversor_de_moedas/conversor.dart';

import 'app/main_LstInfFavorito_ex01.dart';
import 'app/main_ListaInfinita_ex02.dart';

import 'app/drawer_customizado/drawer-customizado-widget.dart';
import 'app/bloc/bloc_flutter1/bloc_flutter1.dart';

import 'app/animação/clap_widget.dart';
import 'app/menu_circular_red/menu-circular-red.dart';
import 'app/flutter_offline/flutter-offline.dart';
import 'app/slide_show/slide-show.dart';

main() {
  runApp(MaterialApp(
    title: 'Programas Curso Flutter.',
    home: Teste(),
    theme: ThemeData(),
    routes: <String, WidgetBuilder>{
      '/ListaInfinitaEx02': (BuildContext context) => ListaInfinitaEx02(),
      '/LstInfFavoritoEx01': (BuildContext context) => LstInfFavoritoEx01(),
      //'Controle Pessoa',
      '/MyAppControlePessoa': (BuildContext context) => MyAppControlePessoa(),
      //'Calcular IMC',
      '/CalculadoraImc': (BuildContext context) => CalculadoraImc(),
      //'Conversor De Moedas',
      '/Conversor': (BuildContext context) => Conversor(),
      //'Menu / Drawer Customizado',
      '/DrawerCustomizadoWidget': (BuildContext context) =>
          DrawerCustomizadoWidget(),
      //'Bloc 001',
      '/BlocFlutter1': (BuildContext context) => BlocFlutter1(),
      '/ClapWidget': (BuildContext context) => ClapWidget(),      
      '/MenuCircularRed': (BuildContext context) => MenuCircularRed(),
      '/FlutterOffline': (BuildContext context) => FlutterOffline(),
      '/SlideShow': (BuildContext context) => SlideShow(),
    },
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
    Widget _listTile(String title, String routeName) {
      return ListTile(
        title: Text(title),
        onTap: () {
          Navigator.of(context).pushNamed(routeName);
        },
        trailing: Icon(Icons.arrow_right),
      );
    }

    Widget _listView() {
      return ListView(
        children: <Widget>[
          _listTile('Lista Infivita', '/ListaInfinitaEx02'),
          _listTile('Lista Infivita Favorito', '/LstInfFavoritoEx01'),
          _listTile('Menu / Drawer Customizado', '/DrawerCustomizadoWidget'),
          _listTile('Slide Show', '/SlideShow'),
          Divider(),
          _listTile('Bloc 001', '/BlocFlutter1'),
          Divider(),
          _listTile('Controle Pessoa', '/MyAppControlePessoa'),
          _listTile('Calcular IMC', '/CalculadoraImc'),
          _listTile('Conversor De Moedas', '/Conversor'),
          _listTile('Clap', '/ClapWidget'),
          _listTile('Menu Circular Red', '/MenuCircularRed'),
          Divider(),
          _listTile('flutter_offline', '/FlutterOffline'),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercícios Flutter'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: _listView(), 
            /* Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: _listView(),
            ),
            RaisedButton(
              child: Text(
                'Lista Infivita Favorito',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LstInfFavoritoEx01()));
              },
            ),
            RaisedButton(
              child: Text(
                'Lista Infivita',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).pushNamed('/ListaInfinitaEx02');
                
              },
            ),
            RaisedButton(
              child: Text(
                'Controle Pessoa',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyAppControlePessoa()));
              },
            ),
            RaisedButton(
              child: Text(
                'Calcular IMC',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CalculadoraImc()));
              },
            ),
            RaisedButton(
              child: Text(
                'Conversor De Moedas',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Conversor()));
              },
            ),
            RaisedButton(
              child: Text(
                'Menu Customizado',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DrawerCustomizadoWidget()));
              },
            ),
            RaisedButton(
              child: Text(
                'Bloc 001',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => BlocFlutter1()));
              },
            ),
          ],
    ),*/
      ),
    );
  }
}
