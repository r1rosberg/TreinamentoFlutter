import 'package:flutter/material.dart';

import './gender_card.dart';
import './weight_card.dart';
import './heigth_card.dart';
import './gender.dart';
import './input_summary_card.dart';
import './pacman_slider.dart';
import './transition_dot.dart';
import './fade_route.dart';
import './result_page.dart';

import './app_bar.dart';
import './input_page_styles.dart';

import './widget_utils.dart' show screenAwareSize;

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> with TickerProviderStateMixin {
  Gender gender = Gender.outros;
  int height = 170;
  int weight = 70;
  AnimationController _submitAnimationController;

  @override
  void initState() {
    super.initState();
    _submitAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _submitAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToResultPage().then((_) => _submitAnimationController.reset());
      }
    });
  }

  _goToResultPage() async {
    return Navigator.of(context).push(FadeRoute(
      builder: (context) => ResultPage(
            widget: weight,
            height: height,
            gender: gender,
          ),
    ));
  }

  @override
  void dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: PreferredSize(
            child: ImcAppBar(),
            preferredSize: Size.fromHeight(appBarHeight(context)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InputSummaryCard(
                gender: gender,
                weight: weight,
                height: height,
              ),
              Expanded(child: _buildCards(context)),
              _buildBottom(context),
            ],
          ),
        ),
        TransitionDot(animation: _submitAnimationController),
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(16, context),
        right: screenAwareSize(16, context),
        bottom: screenAwareSize(22, context),
        top: screenAwareSize(14, context),
      ),
      child: PacmanSlider(
        onSubmit: onPacmanSubmit,
        submitAnimationController: _submitAnimationController,
      ), /*Placeholder(
        fallbackHeight: screenAwareSize(52, context),
        color: Theme.of(context).primaryColor,
    ),*/
    );
  }

  void onPacmanSubmit() {
    _submitAnimationController.forward();
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: screenAwareSize(16.0, context),
          right: screenAwareSize(16.0, context),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GenderCard(
                      gender: gender,
                      onChanged: (val) => setState(() => gender = val),
                    ),
                  ),
                  Expanded(
                    child: WeightCard(
                      weight: weight,
                      onChanged: (val) => setState(() => weight = val),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: HeightCard(
                height: height,
                onChanged: (val) => setState(() => height = val),
              ),
            ),
          ],
        ));
  }

  /*Widget _tempCard(String label) {
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(label),
      ),
    );
  }*/
}
