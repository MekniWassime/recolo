import 'package:flutter/material.dart';
import 'package:recolo/models/journal_metadata.dart';
import 'package:recolo/modules/journal/widgets/journal_entry.dart';
import 'package:recolo/modules/journal/widgets/loading_journal_entry.dart';
import 'package:recolo/utility/date_utility.dart';
import 'package:shimmer/shimmer.dart';

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
