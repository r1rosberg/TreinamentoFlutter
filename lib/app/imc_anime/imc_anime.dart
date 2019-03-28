/**
 * https://marcinszalek.pl/flutter/bmi-calculator-gender/
 * CALCULADORA DE IMC EM FLUTTER
 */
/*import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;*/

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import './calculadora_imc/input_page.dart';

/*void main() {

 runApp(new MyApp());
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  //mudamos a cor da barra de navegação
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}*/

class ImcAnime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: InputPage(),
    );
  }
}
