import 'package:flutter/material.dart';
import 'package:recolo/constants/app_colors.dart';
import 'package:recolo/models/journal_metadata.dart';
import 'package:recolo/utility/date_utility.dart';

class JournalEntry extends StatelessWidget {
  const JournalEntry(
      {Key? key, required this.metadata, this.onTap, this.onLongPress})
      : super(key: key);
  final JournalMetadata metadata;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    bool hasTitle = metadata.title != "";
    return ListTile(
      contentPadding:
          const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 20),
      onTap: onTap,
      onLongPress: onLongPress,
      leading: const Icon(
        Icons.lock,
        color: AppColors.fadedText,
        size: 30,
      ),
      title: Text(
        hasTitle
            ? metadata.title.toUpperCase()
            : DateUtility.toEEEEMMMyyyy(metadata.date),
      ),
      subtitle: Text(DateUtility.toddMMyyyy(metadata.date)),
      trailing: Icon(
        JournalMetadata.ratingIconMap[metadata.rating],
        color: JournalMetadata.ratingColorMap[metadata.rating],
        size: 60,
      ),
    );
  }
}
