import 'package:flutter/material.dart';
import 'package:recolo/widgets/main_app_bar.dart';

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
    return Scaffold(
      body: SafeArea(child: body),
      appBar: appBar,
    );
  }
}
