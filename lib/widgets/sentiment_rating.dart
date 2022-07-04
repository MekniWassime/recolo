import 'package:flutter/material.dart';
import 'package:recolo/constants/app_colors.dart';
import 'package:recolo/models/journal_metadata.dart';

class SentimentRating extends StatelessWidget {
  const SentimentRating({Key? key, required this.controller}) : super(key: key);

  final ValueNotifier<int> controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) => ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (context, index) {
          index = index - 2;
          return GestureDetector(
            onTap: () {
              controller.value = index;
            },
            child: Icon(
              JournalMetadata.ratingIconMap[index],
              color: value == index
                  ? JournalMetadata.ratingColorMap[index]
                  : AppColors.fadedText,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
