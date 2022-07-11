import 'package:flutter/material.dart';
import 'package:recolo/widgets/main_app_bar.dart';

class JournalScreenScaffhold extends StatelessWidget {
  const JournalScreenScaffhold({
    Key? key,
    required this.body,
    required this.onFloatingButtonPressed,
    required this.goToTopVisibilityController,
    required this.onGoToTopButtonPressed,
  }) : super(key: key);

  final ValueNotifier<bool> goToTopVisibilityController;
  final Widget body;
  final void Function() onFloatingButtonPressed;
  final void Function() onGoToTopButtonPressed;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: MainAppBar(title: "Recolo"),
      body: SafeArea(
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              primaryColor.withOpacity(0),
              primaryColor.withOpacity(0.9),
              primaryColor.withOpacity(0),
              primaryColor.withOpacity(0.5),
              primaryColor.withOpacity(0),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: body),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
            height: 45.0,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: ValueListenableBuilder<bool>(
                        valueListenable: goToTopVisibilityController,
                        builder: (context, isVisible, child) => AnimatedOpacity(
                              opacity: isVisible ? 1 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: IconButton(
                                onPressed:
                                    isVisible ? onGoToTopButtonPressed : null,
                                icon: const Icon(
                                  Icons.arrow_upward,
                                ),
                                disabledColor:
                                    Theme.of(context).iconTheme.color,
                              ),
                            ))))),
        notchMargin: 10,
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: onFloatingButtonPressed,
          tooltip: 'Reflect on your day',
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
