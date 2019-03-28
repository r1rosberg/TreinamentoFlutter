import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

import './gender.dart';
import './card_title.dart';

import 'widget_utils.dart' show screenAwareSize;

double _circleSize(BuildContext context) => screenAwareSize(80.0, context);

const double _defaultGenderAngle = math.pi / 4;

const Map<Gender, double> _genderAngles = {
  Gender.feminino: -_defaultGenderAngle,
  Gender.outros: 0.0,
  Gender.masculino: _defaultGenderAngle,
};

class GenderCard extends StatefulWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const GenderCard({Key key, this.gender, this.onChanged}) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  AnimationController _arrowAnimationCtrl;
  Gender selectedGender;

  @override
  void initState() {
    super.initState();
    this.selectedGender = widget.gender ?? Gender.outros;
    this._arrowAnimationCtrl = new AnimationController(
      vsync: this,
      lowerBound: -_defaultGenderAngle,
      upperBound: _defaultGenderAngle,
      value: _genderAngles[selectedGender],
    );
  }

  @override
  void dispose() {
    super.dispose();
    this._arrowAnimationCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle('GENERO'),
            Padding(
              padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
              child: _drawMainStack(),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawMainStack() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _drawCircleIndicator(),
          GenderIconTranslated(gender: Gender.feminino),
          GenderIconTranslated(gender: Gender.outros),
          GenderIconTranslated(gender: Gender.masculino),
          _drawGestureDetector(),
        ],
      ),
    );
  }

  Widget _drawCircleIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
        GenderArrow(listenable: this._arrowAnimationCtrl),
      ],
    );
  }

  _drawGestureDetector() {
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  void _setSelectedGender(Gender gender) {
    widget.onChanged(gender);

    setState(() {
      selectedGender = gender;
    });
    _arrowAnimationCtrl.animateTo(
      _genderAngles[gender],
      duration: Duration(milliseconds: 250),
    );
  }
}

class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _circleSize(context),
      height: _circleSize(context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(244, 244, 244, 1.0),
      ),
    );
  }
}

class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenAwareSize(6.0, context),
        top: screenAwareSize(8.0, context),
      ),
      child: Container(
        height: screenAwareSize(8.0, context),
        width: 1.0,
        color: Color.fromRGBO(216, 217, 223, 0.54),
      ),
    );
  }
}

class GenderIconTranslated extends StatelessWidget {
  static final Map<Gender, String> _genderImages = {
    Gender.feminino: 'images/femenine.svg',
    Gender.outros: 'images/gender.svg',
    Gender.masculino: 'images/masculine.svg',
  };

  final Gender gender;

  const GenderIconTranslated({Key key, this.gender}) : super(key: key);

  bool get _isOtherGender => gender == Gender.outros;

  String get _assetName => _genderImages[gender];

  double _iconSize(BuildContext context) {
    return screenAwareSize(this._isOtherGender ? 22.0 : 16.0, context);
  }

  double _genderLeftPadding(BuildContext context) {
    return screenAwareSize(this._isOtherGender ? 8.0 : 0.0, context);
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = Padding(
      padding: EdgeInsets.only(
        left: this._genderLeftPadding(context),
      ),
      child: SvgPicture.asset(
        this._assetName,
        height: this._iconSize(context),
        width: this._iconSize(context),
      ),
    );

    Widget rotatedIcon = Transform.rotate(
      angle: -_genderAngles[gender],
      child: icon,
    );

    Widget iconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rotatedIcon,
          GenderLine(),
        ],
      ),
    );

    Widget rotatedIconWithALine = Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: _genderAngles[gender],
      child: iconWithALine,
    );

    Widget centeredIconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context) / 2),
      child: rotatedIconWithALine,
    );

    return centeredIconWithALine;
  }
}

/*
 * 2.4 The arrow   
 */

class GenderArrow extends AnimatedWidget {
  const GenderArrow({Key key, Listenable listenable})
      : super(key: key, listenable: listenable);

  double _arrowLength(BuildContext context) => screenAwareSize(36.0, context);
  double _translationOffset(BuildContext context) =>
      _arrowLength(context) * -0.4;

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Transform.rotate(
      angle: animation.value,
      child: Transform.translate(
        offset: Offset(0.0, _translationOffset(context)),
        //child: Transform.rotate(
        //  angle: 0.0, //-_defaultGenderAngle,*/
        child: SvgPicture.asset(
          'images/drop.svg',
          color: Colors.blueAccent,
          height: _arrowLength(context),
          //width: _arrowLength(context),
        ),
        //),
      ),
    );
  }
}

/*
 * 3. Interactivity
 * 3.1 Handle tapping
 */
class TapHandler extends StatelessWidget {
  final Function(Gender) onGenderTapped;

  const TapHandler({Key key, this.onGenderTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderTapped(Gender.feminino),
          ),
        ),
        Expanded(          
          child: GestureDetector(
            onTap: () => onGenderTapped(Gender.outros),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderTapped(Gender.masculino),
          ),
        ),
      ],
    );
  }
}
