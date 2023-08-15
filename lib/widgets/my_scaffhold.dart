import 'package:flutter/material.dart';

class MyScaffhold extends StatelessWidget {
  const MyScaffhold({
    Key? key,
    required this.body,
    required this.appBar,
  }) : super(key: key);

  final Widget body;
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            primaryColor.withOpacity(0),
            primaryColor.withOpacity(0.55),
            primaryColor.withOpacity(0),
            primaryColor.withOpacity(0.35),
            primaryColor.withOpacity(0),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: body,
        ),
      ),
      appBar: appBar,
    );
  }
}
