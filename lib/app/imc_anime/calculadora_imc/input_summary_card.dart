import 'package:flutter/material.dart';

import './gender.dart';

import './widget_utils.dart' show screenAwareSize;

class InputSummaryCard extends StatelessWidget {
  final Gender gender;
  final int height;
  final int weight;

  const InputSummaryCard({
    Key key,
    this.gender,
    this.height,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(screenAwareSize(16.0, context)),
      child: SizedBox(
        height: screenAwareSize(32.0, context),
        child: Row(
          children: <Widget>[
            Expanded(child: _genderText()),
            _divisor(),
            Expanded(child: _text('${weight}kg')),
            _divisor(),
            Expanded(child: _text('${height}kg')),
          ],
        ),
      ),
    );
  }

  Widget _genderText() {
    String genderText = gender == Gender.outros
        ? '-'
        : (gender == Gender.feminino ? 'Feminino' : 'Masculino');
    return _text(genderText);
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(143, 144, 156, 1),
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _divisor() {
    return Container(
      width: 1.0,
      color: Color.fromRGBO(151, 151, 151, 0.1),
    );
  }
}
