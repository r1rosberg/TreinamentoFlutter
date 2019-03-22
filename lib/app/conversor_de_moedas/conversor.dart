import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/* json editor online 
   https://jsoneditoronline.org/
   https://jsonformatter.org/json-editor
   https://hgbrasil.com/status/finance/
   https://api.hgbrasil.com/finance/quotations?format=json&key=60df7606

   http: ^0.12.0+1
*/

Future<Map> getData() async {
  const String url_request =
      'https://api.hgbrasil.com/finance/quotations?format=json&key=60df7606';
  var response = await http.get(url_request);

  return json.decode(response.body);

  //http.get(url_request).then((val) {
  //  print(val.body);
  //});
}

class Conversor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(getData());
    return _Conversor();
    /* MaterialApp(
      title: 'Conversor de Moeda',
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
      ),
      home: _Conversor(),
    );*/
  }
}

class _Conversor extends StatefulWidget {
  @override
  _ConversorState createState() => _ConversorState();
}

class _ConversorState extends State<_Conversor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Conversor de Moeda'),
      ),
      body: Column(
        //children: <Widget>[TextField(decoration: ,),],  
      ),
    );
  }
}
