//https://flutterando.com.br/2018/10/19/criando-um-drawer-altamente-customizado/

import 'package:flutter/material.dart';
import './Drawer/drawer-widget.dart';
import './Screen/screen-widget.dart';

class DrawerCustomizadoWidget extends StatefulWidget {
  @override
  _DrawerCustomizadoWidgetState createState() =>
      _DrawerCustomizadoWidgetState();
}

class _DrawerCustomizadoWidgetState extends State<DrawerCustomizadoWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animationTranslate;
  Animation animationSize;
  Animation animationSizeBorder;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    animationTranslate = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    animationTranslate.addListener(() {
      setState(() {});
    });

    animationSize = Tween(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    animationSize.addListener(() {
      setState(() {});
    });

    animationSizeBorder = Tween(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    animationSizeBorder.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DrawerWidget(),
        Transform.scale(
          scale: animationSize.value,
          child: Container(
            transform: Matrix4.identity()
              ..translate(animationTranslate.value, 0.0),
            child: Material(
              elevation: 30,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(animationSizeBorder.value),
                child: ScreenWidget(onTap: _onTapMenu),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onTapMenu() {
    if (controller.value == 1) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}
