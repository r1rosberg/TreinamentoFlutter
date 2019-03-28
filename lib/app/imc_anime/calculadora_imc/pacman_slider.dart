import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './widget_utils.dart';

const double _pacmanWidth = 30.0;
const double _sliderHorizontalMargin = 24.0;
const double _dotsLeftMargin = 8.0;

class PacmanSlider extends StatefulWidget {
  final VoidCallback onSubmit;
  final AnimationController submitAnimationController;
  const PacmanSlider({Key key, this.onSubmit, this.submitAnimationController})
      : super(key: key);

  @override
  _PacmanSliderState createState() => _PacmanSliderState();
}

class _PacmanSliderState extends State<PacmanSlider>
    with TickerProviderStateMixin {
  double _pacmanPosition = _sliderHorizontalMargin;
  Animation<Offset> pacmanAnimation;
  AnimationController pacmanMovementController;
  Animation<BorderRadius> _bordersAnimation;
  Animation<double> _submitWidthAnimation;

  double width = 0.0;

  @override
  void initState() {
    super.initState();
    pacmanMovementController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _bordersAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(8.0),
      end: BorderRadius.circular(50.0),
    ).animate(CurvedAnimation(
      parent: widget.submitAnimationController,
      curve: Interval(0.0, 0.07),
    ));
  }

  @override
  void dispose() {
    pacmanMovementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        width = constraints.maxWidth;

        _submitWidthAnimation = Tween<double>(
          begin: width,
          end: screenAwareSize(52, context),
        ).animate(CurvedAnimation(
          parent: widget.submitAnimationController,
          curve: Interval(0.05, 0.15),
        ));

        return AnimatedBuilder(
          animation: widget.submitAnimationController,
          builder: (context, child) {
            Decoration decoration = BoxDecoration(
              borderRadius: _bordersAnimation.value,
              color: Theme.of(context).primaryColor,
            );

            return Center(
              child: Container(
                height: screenAwareSize(52.0, context),
                width: _submitWidthAnimation.value,
                decoration: decoration,
                child: _submitWidthAnimation.isDismissed
                    ? GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => _animatePacmanToEnd(),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            AnimatedDots(),
                            _drawDotCurtain(decoration),
                            _drawPacman(),
                          ],
                        ),
                      )
                    : Container(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _drawDotCurtain(Decoration decoration) {
    if (width == 0.0) {
      return Container();
    }

    double marginRight =
        width - _pacmanPosition - screenAwareSize(_pacmanWidth / 2, context);

    return Positioned.fill(
      right: marginRight,
      child: Container(
        decoration: decoration,
      ),
    );
  }

  Widget _drawPacman() {
    //if (pacmanAnimation == null && width != 0.0) {
    pacmanAnimation = _initPacmanAnimation(width);
    //}
    return Positioned(
      left: _pacmanPosition,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => _onPacmanDrag(details),
        onHorizontalDragEnd: (details) => _onPacmanEnd(details),
        child: PacmanIcon(),
      ),
    );
  }

  Animation<Offset> _initPacmanAnimation(double width) {
    Animation<Offset> animation = Tween(
      begin: Offset(_pacmanMinPosition(), 0.0),
      end: Offset(_pacmanMaxPosition(width), 0.0),
    ).animate(pacmanMovementController);

    animation.addListener(() {
      setState(() {
        _pacmanPosition = animation.value.dx;
      });
      if (animation.status == AnimationStatus.completed) {
        widget?.onSubmit();
        _onPacmanSubmited();
      }
    });
    return animation;
  }

  _onPacmanSubmited() {
    //temporary:
    Future.delayed(Duration(seconds: 1), () => _resetPacman());
  }

  void _onPacmanEnd(DragEndDetails details) {
    bool isOverHalf =
        _pacmanPosition + screenAwareSize(_pacmanWidth / 2, context) >
            0.5 * width;
    if (isOverHalf) {
      // animação para o fim.
      _animatePacmanToEnd();
    } else {
      _resetPacman();
    }
  }

  void _animatePacmanToEnd() {
    pacmanMovementController.forward(
        from: _pacmanPosition / _pacmanMaxPosition(width));
  }

  void _resetPacman() {
    setState(() {
      _pacmanPosition = _pacmanMinPosition();
    });
  }

  void _onPacmanDrag(DragUpdateDetails details) {
    setState(() {
      _pacmanPosition += details.delta.dx;
      _pacmanPosition = math.max(_pacmanMinPosition(),
          math.min(_pacmanMaxPosition(width), _pacmanPosition));
    });
  }

  _pacmanMinPosition() {
    return screenAwareSize(_sliderHorizontalMargin, context);
  }

  _pacmanMaxPosition(double sliderWidth) {
    return sliderWidth -
        screenAwareSize(_sliderHorizontalMargin / 2 + _pacmanWidth, context);
  }
}

class AnimatedDots extends StatefulWidget {
  @override
  _AnimatedDotsState createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with SingleTickerProviderStateMixin {
  final int numberOfDots = 10;
  final double minOpacity = 0.1;
  final double maxOpacity = 0.8;
  AnimationController hintAnimationController;

  @override
  void initState() {
    super.initState();
    _initHintAnimationController();
    hintAnimationController.forward();
  }

  @override
  void dispose() {
    hintAnimationController.dispose();
    super.dispose();
  }

  void _initHintAnimationController() {
    hintAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    hintAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 800), () {
          hintAnimationController.forward(from: 0.0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(
            _sliderHorizontalMargin + _pacmanWidth + _dotsLeftMargin, context),
        right: screenAwareSize(_sliderHorizontalMargin, context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(numberOfDots, _generateDot)
          ..add(Opacity(
            opacity: maxOpacity,
            child: Dot(size: 14.0),
          )),
      ),
    );
  }

  Widget _generateDot(int dotNumber) {
    Animation animation = _initDotAnimation(dotNumber);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
            opacity: animation.value,
            child: child,
          ),
      child: Dot(size: 9.0),
    );
  }

  Animation<double> _initDotAnimation(int dotNumber) {
    double lastDotStartTime = 0.4;
    double dotAnimationDuration = 0.5;
    double begin = lastDotStartTime * dotNumber / numberOfDots;
    double end = begin + dotAnimationDuration;
    return SinusoidalAnimation(min: minOpacity, max: maxOpacity).animate(
      CurvedAnimation(
        parent: hintAnimationController,
        curve: Interval(begin, end),
      ),
    );
  }
}

class SinusoidalAnimation extends Animatable<double> {
  final double min;
  final double max;

  SinusoidalAnimation({this.min, this.max});

  @protected
  double lerp(double t) {
    return min + (max - min) * math.sin(math.pi * t);
  }

  @override
  double transform(double t) {
    return (t == 0.0 || t == 1.0) ? min : lerp(t);
  }
}

class Dot extends StatelessWidget {
  final double size;

  const Dot({Key key, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenAwareSize(size, context),
      width: screenAwareSize(size, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

class PacmanIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /*Padding(
      padding: EdgeInsets.only(
        right: screenAwareSize(16.0, context),
      ),
      child:*/
        SvgPicture.asset(
      'images/pacman.svg',
      height: screenAwareSize(_pacmanWidth, context),
      color: Colors.white,
      //),
    );
  }
}
