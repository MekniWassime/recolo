import 'package:flutter/material.dart';

class EmptyJournalList extends StatelessWidget {
  const EmptyJournalList({
    Key? key,
    required this.onCreateButtonPressed,
  }) : super(key: key);

  final void Function() onCreateButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Looks like you haven't written any journals yet!",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: onCreateButtonPressed,
              child: Text(
                "Create one for today",
                style: Theme.of(context).textTheme.titleLarge,
              )),
        ],
      ),
    );
  }
}
