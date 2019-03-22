//https://proandroiddev.com/flutter-animation-creating-mediums-clap-animation-in-flutter-3168f047421e
//https://github.com/Kartik1607/FlutterUI/tree/master/MediumClapAnimation/medium_clap
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ClapWidget extends StatefulWidget {
  @override
  _ClapWidgetState createState() => _ClapWidgetState();
}

enum ScoreWidgetStatus { HIDDEN, VISIBLE, BECOMING_VISIBLE, BECOMING_INVISIBLE }

class _ClapWidgetState extends State<ClapWidget> with TickerProviderStateMixin {
  int _counter = 0;
  final duration = Duration(milliseconds: 800);
  final oneSecond = Duration(seconds: 1);
  Timer holdTimer;
  Timer scoreOutETA;
  AnimationController scoreInAnimationController;
  AnimationController scoreOutAnimationController;
  AnimationController scoreSizeAnimationController;

  Animation scoreOutPositionAnimation;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;

  double _sparklesAngle = 0.0;
  math.Random random;
  AnimationController sparklesAnimationController;
  Animation sparklesAnimation;

  @override
  void initState() {
    super.initState();
    random = math.Random();

    scoreInAnimationController =
        AnimationController(duration: duration, vsync: this);
    scoreInAnimationController.addListener(() {
      //print('subi ${scoreInAnimationController.value}');
      setState(() {});
    });

    scoreOutAnimationController =
        AnimationController(duration: duration, vsync: this);

    scoreOutAnimationController.addListener(() {
      //print('fui ${scoreOutAnimationController.value}');
      setState(() {});
    });

    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });

    scoreOutPositionAnimation = Tween<double>(begin: 300.0, end: 450.0).animate(
        CurvedAnimation(
            parent: scoreOutAnimationController, curve: Curves.easeOut));

    scoreSizeAnimationController =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    scoreSizeAnimationController.addListener(() {
      setState(() {});
    });
    scoreSizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });

    sparklesAnimationController =
        new AnimationController(duration: duration, vsync: this);
    sparklesAnimation = new CurvedAnimation(
        parent: sparklesAnimationController, curve: Curves.easeIn);
    sparklesAnimation.addListener(() {
      setState(() {});
    });
  }

  /* @override
  void didChangeDependencies() {
    print('didChangeDependencies');
  }*/

  @override
  void dispose() {
    scoreInAnimationController.dispose();
    scoreOutAnimationController.dispose();
    scoreSizeAnimationController.dispose();
    sparklesAnimationController.dispose();
    super.dispose();
  }

  void increment(Timer t) {
    scoreSizeAnimationController.forward(from: 0.0);
    sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
      _sparklesAngle = random.nextDouble() * (2 * math.pi);
    });
  }

  void _onTapDown(TapDownDetails tapDown) {
    if (scoreOutETA != null) scoreOutETA.cancel();

    if (_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    } else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN) {
      scoreInAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
    }

    increment(null);
    holdTimer = Timer.periodic(duration, increment);
  }

  void _onTapUp(TapUpDetails tapUp) {
    scoreOutETA = Timer(oneSecond, () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });
    holdTimer.cancel();
  }

  Widget getScoreButton() {
    //var scorePosition = scoreInAnimationController.value *   MediaQuery.of(context).size.height /  2;
    //var scoreOpacity = scoreInAnimationController.value;
    double scorePosition = 0;
    double scoreOpacity = 0;
    double extraSize = 0.0;

    switch (_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE:
      case ScoreWidgetStatus.VISIBLE:
        scorePosition = scoreInAnimationController.value * 300;
        scoreOpacity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 40;
        break;
      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
        break;
    }

    var stackChildren = <Widget>[];

    var firstAngle = _sparklesAngle;
    var sparklesRadius = (sparklesAnimationController.value * 50) + 50;
    var sparklesOpacity = (1 - sparklesAnimation.value);

    stackChildren.add(Opacity(
      opacity: scoreOpacity,
      child: Container(
        height: 90 + extraSize,
        width: 90 + extraSize,
        decoration: ShapeDecoration(
          shape: CircleBorder(side: BorderSide.none),
          color: Colors.pink,
        ),
        child: Center(
          child: Text(
            "+$_counter",
            style: TextStyle(
                fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ));

    for (int i = 0; i < 5; ++i) {
      var currentAngle = (firstAngle + ((2 * math.pi) / 5) * (i));
      print('($firstAngle + ((2 * ${math.pi}) / 5) * ($i)) = $currentAngle');
      var sparklesWidget = Positioned(
        child: Transform.rotate(
          angle: currentAngle - math.pi / 2,
          child: Opacity(
            opacity: sparklesOpacity,
            child: Icon(
              Icons.arrow_drop_up,
              size: 50.0,
              color: Colors.pink
            ),
          ),
        ),
        left: (sparklesRadius * math.cos(currentAngle)) + 28,
        top: (sparklesRadius * math.sin(currentAngle)) + 28,
      );
      stackChildren.add(sparklesWidget);
    }

    return new Positioned(
      child: Stack(
        alignment: FractionalOffset.center,
        overflow: Overflow.visible,
        children: stackChildren,
      ),
      bottom: scorePosition,
    );
  }

  Widget getClapButton() {
    var extraSize = 0.0;
    if (_scoreWidgetStatus == ScoreWidgetStatus.VISIBLE ||
        _scoreWidgetStatus == ScoreWidgetStatus.BECOMING_VISIBLE) {
      extraSize = scoreSizeAnimationController.value * 40;
    }

    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      child: Container(
          height: 110 + extraSize,
          width: 110 + extraSize,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.pink, width: 1),
              borderRadius: BorderRadius.circular(80),
              color: Colors.white,
              boxShadow: [new BoxShadow(color: Colors.pink, blurRadius: 8.0)]),
          child: Image.asset(
            'images/clap.png',
            height: 50,
          )
          //ImageIcon( AssetImage('images/claptransparent.jpg'), size: 30,),
          //),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clap Clap')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: <Widget>[
            getScoreButton(),
            getClapButton(),
          ],
        ),
      ),
    );
  }
}
