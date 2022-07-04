import 'package:flutter/material.dart';
import 'package:recolo/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingJournalEntry extends StatelessWidget {
  const LoadingJournalEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: AppColors.interactableColor,
      baseColor: AppColors.fadedText,
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 20),
        leading: Container(color: Colors.white, width: 40, height: 40),
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Container(height: 14, width: 20, color: Colors.white),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(right: 100),
          child: Container(height: 10, width: 20, color: Colors.white),
        ),
        trailing: const Icon(
          Icons.circle,
          size: 60,
        ),
      ),
    );
  }
}
