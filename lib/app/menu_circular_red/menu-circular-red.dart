//https://marcinszalek.pl/flutter/filter-menu-ui-challenge/
//https://dribbble.com/shots/1956586-Filter-Menu

import 'package:flutter/material.dart';
import './menu-circular-component.dart';
import './list-model.dart';

class MenuCircularRed extends StatefulWidget {
  @override
  _MenuCircularRedState createState() => _MenuCircularRedState();
}

class _MenuCircularRedState extends State<MenuCircularRed>
    with MenuCircularComponent {
  @override
  void initState() {
    super.initState();
    listModel = ListModel(listkey: listKey, items: tasks);
  }

  @override
  Widget build(BuildContext context) {
    imageHeight = MediaQuery.of(context).size.height * 0.35;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          buidTimeLine(),
          buildImage(),
          buildTopHeader(),
          buildProfileRow(),
          buildBottomPart(),
          buidFab(),
        ],
      ),
    );
  }
}
