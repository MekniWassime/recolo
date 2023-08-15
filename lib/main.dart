import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recolo/constants/app_themes.dart';
import 'package:recolo/modules/grid_view/screens/grid_view_screen.dart';
import 'package:recolo/modules/journal/notifiers/journal_notifier.dart';
import 'package:recolo/splash_screen_app.dart';

void main() {
  runApp(const SplashScreenApp(
    initializationDoneCallback: runMainApp,
  ));
}

void runMainApp() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => JournalNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recolo',
      theme: AppThemes.darkTheme,
      home: const GridViewScreen(),
    );
  }
}
