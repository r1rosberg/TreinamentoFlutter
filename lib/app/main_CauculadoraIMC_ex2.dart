import 'package:flutter/material.dart';

class CalculadoraImc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyStatefulWidget> {
  TextEditingController _pesoKgCtrl = TextEditingController();
  TextEditingController _alturaCmCtrl = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _resultado = "Insira suas informações";

  void _resetar() {
    _pesoKgCtrl.text = "";
    _alturaCmCtrl.text = "";
    setState(() {
      _resultado = "Insira suas informações";
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(_pesoKgCtrl.text);
      double altura = double.parse(_alturaCmCtrl.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 17) {
        _resultado = "Muito abaixo do peso. IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc > 17 && imc < 18.49) {
        _resultado = "Abaixo do peso ideal. IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc > 18.5 && imc < 24.99) {
        _resultado = "Peso normal. IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc > 25 && imc < 29.99) {
        _resultado = "Acima do peso ideal. IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc > 30 && imc < 34.99) {
        _resultado = "Obesidade I. IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc > 35 && imc < 39.99) {
        _resultado =
            "Obesidade II (severa). IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc > 40) {
        _resultado =
            "Obesidade III (mórbida). IMC: ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calculadora IMC", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            tooltip: "Resertar",
            onPressed: _resetar,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                color: Colors.green,
                size: 120.0,
              ),
              TextFormField(
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _pesoKgCtrl,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25.0)),
                validator: (value) {
                  if (value == '' || value.isEmpty) {
                    return 'Informe o peso.';
                  }
                },
              ),
              TextFormField(
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _alturaCmCtrl,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25.0)),
                validator: (value) {
                  if (value == '' || value.isEmpty) {
                    return 'Informe a altura.';
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                height: 80.0,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calcularIMC();
                    }
                  },
                  child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  color: Colors.green,
                ),
              ),
              Text(
                _resultado,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
