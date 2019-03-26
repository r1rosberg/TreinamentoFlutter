import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  final VoidCallback onClick;

  const AnimatedFab({Key key, this.onClick}) : super(key: key);

  @override
  _AnimatedFabState createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  final double expandedSize = 180.0;

  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _colorAnimation = ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expandedSize,
      height: expandedSize,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildExpandedBackground(),
              _buildOption(Icons.check_circle, 0.0, widget.onClick),
              _buildOption(Icons.flash_on, -math.pi / 3, null),
              _buildOption(Icons.access_time, -2 * math.pi / 3, null),
              _buildOption(Icons.error_outline, math.pi, null),
              _buildFabCore(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOption(IconData icon, double angle, Function onPressed) {
    double iconSize = 0.0;

    if (_animationController.value > 0.8) {
      iconSize = 26 * (_animationController.value - 0.8) * 5;
    }

    return Transform.rotate(
      angle: angle,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: IconButton(
            iconSize: iconSize,
            onPressed: onPressed,
            icon: Transform.rotate(
              angle: -angle,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedBackground() {
    double expandedSize = 180.0;
    double hiddenSize = 20.0;
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  Widget _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    print(scaleFactor);

    return FloatingActionButton(
      onPressed: _onFabTap,
      child: Transform(
        alignment: Alignment.center,
        transform: new Matrix4.identity()..scale(1.0, scaleFactor),
        child: Icon(
          _animationController.value > 0.5 
          ? Icons.close 
          : Icons.filter_list,
          color: Colors.white,
          size: 26.0,
        ),
      ),
      backgroundColor: _animationController.value > 0.5 
      ? _colorAnimation.value 
      : Colors.black,
    );
  }

  _open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  _close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed) {
      _open();
    } else {
      _close();
    }
  }
}
