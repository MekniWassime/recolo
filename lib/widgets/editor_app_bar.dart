import 'package:flutter/material.dart';
import 'package:recolo/constants/app_colors.dart';
import 'package:recolo/widgets/sentiment_rating.dart';

class EditorAppBar extends AppBar {
  EditorAppBar({
    Key? key,
    required BuildContext context,
    String? subTitle,
    required ValueNotifier<int> ratingController,
    required TextEditingController textController,
    required FocusNode focusNode,
  }) : super(
            key: key,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: EditableText(
                    controller: textController,
                    backgroundCursorColor:
                        Theme.of(context).inputDecorationTheme.fillColor!,
                    focusNode: focusNode,
                    cursorColor:
                        Theme.of(context).inputDecorationTheme.fillColor!,
                    style: Theme.of(context).textTheme.headline6 ??
                        const TextStyle(),
                  ),
                  flex: 2,
                ),
                if (subTitle != null)
                  Flexible(
                    child: Text(
                      subTitle,
                      style: const TextStyle(
                        color: AppColors.fadedText,
                        fontSize: 17,
                      ),
                    ),
                  ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Expanded(
                  child: SentimentRating(
                controller: ratingController,
              )),
            ));
}
