import 'package:flutter/material.dart';
import 'package:recolo/modules/journal/widgets/loading_journal_entry.dart';

class LoadingJournals extends StatelessWidget {
  const LoadingJournals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
          height: 2, decoration: BoxDecoration(color: backgroundColor)),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const LoadingJournalEntry(),
      itemCount: 30,
    );
  }
}
