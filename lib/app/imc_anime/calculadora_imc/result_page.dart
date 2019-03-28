import 'package:flutter/material.dart';
import './gender.dart';

import './app_bar.dart';
import './input_page_styles.dart';

class ResultPage extends StatelessWidget {
  final int widget;
  final int height;
  final Gender gender;

  const ResultPage({Key key, this.widget, this.height, this.gender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: ImcAppBar(),
        preferredSize: Size.fromHeight(appBarHeight(context)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Resultado'),
            Card(
              elevation: 5.0,
              child: Text(
                '22.3',
                style: TextStyle(
                  fontSize: 120.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(60),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.sentiment_dissatisfied),
                    onPressed: () => {},
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
