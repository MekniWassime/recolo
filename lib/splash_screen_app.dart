import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recolo/constants/app_colors.dart';
import 'package:recolo/services/file_service.dart';

class SplashScreenApp extends StatefulWidget {
  final Function _initializationDoneCallback;
  const SplashScreenApp(
      {Key? key, required Function initializationDoneCallback})
      : _initializationDoneCallback = initializationDoneCallback,
        super(key: key);

  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  void initState() {
    _initializeServices();
    super.initState();
  }

  Future _initializeServices() async {
    await dotenv.load(fileName: ".env");
    await FileService.initService();
    widget._initializationDoneCallback();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Recolo",
      theme: ThemeData(),
      home: body(),
    );
  }

  Widget body() {
    return Container(
      color: AppColors.backgroundColor,
    );
  }
}
