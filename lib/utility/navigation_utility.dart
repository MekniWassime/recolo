import 'package:flutter/material.dart';

class NavigationUtility {
  NavigationUtility.of(this.context);

  final BuildContext context;

  void pushScreen(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }
}
