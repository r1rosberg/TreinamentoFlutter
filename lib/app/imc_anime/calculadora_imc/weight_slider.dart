/*
 * https://marcinszalek.pl/flutter/bmi-calculator-weight/
 */
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightSlider extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final double width;
  final int value;
  final ValueChanged<int> onChanged;
  final ScrollController scrollController;

  WeightSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.value,
    @required this.onChanged,
    @required this.width,
  })  : scrollController = ScrollController(
          initialScrollOffset: (value - minValue) * width / 3,
        ),
        super(key: key);

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  Widget build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index);
          bool isExtra = ((index == 0) || (index == itemCount - 1));

          return isExtra
              ? new Container()
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _animateTo(itemValue, durationMillis: 600),
                  child: FittedBox(
                    child: new Text(
                      itemValue.toString(),
                      style: _getTextStyle(itemValue),
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                );
        },
      ),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 14.0,
    );
  }

  TextStyle _getHighlighTextStyle() {
    return TextStyle(
      color: Color.fromRGBO(77, 123, 243, 1.0),
      fontSize: 28.0,
    );
  }

  TextStyle _getTextStyle(int itemValue) {
    return itemValue == value
        ? _getHighlighTextStyle()
        : _getDefaultTextStyle();
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  void _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue, durationMillis: 500);
      }

      if (middleValue != value) {
        onChanged(middleValue);
      }
    }
    return true;
  }
}