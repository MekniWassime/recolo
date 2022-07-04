import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class JournalMetadata {
  final String fileName;
  final int rating; //-2, -1, 0, 1, 2
  final DateTime date;
  final String title;

  JournalMetadata({
    required this.date,
    this.rating = 0,
    this.title = "",
  })  : fileName = "${date.millisecondsSinceEpoch}.json",
        assert(rating >= -2 && rating <= 2, "value $rating is invalid");

  static Future<JournalMetadata> fromFile(File file) async {
    final jsonFileContent = jsonDecode(await file.readAsString());
    return JournalMetadata(
      rating: jsonFileContent['rating'],
      date: DateTime.parse(jsonFileContent['date']),
      title: jsonFileContent['title'],
    );
  }

  JournalMetadata copyWith({String? newTitle, int? newRating}) {
    return JournalMetadata(
      rating: newRating ?? rating,
      date: date,
      title: newTitle ?? title,
    );
  }

  static const ratingIconMap = {
    -2: Icons.sentiment_very_dissatisfied,
    -1: Icons.sentiment_dissatisfied,
    0: Icons.sentiment_neutral,
    1: Icons.sentiment_satisfied,
    2: Icons.sentiment_very_satisfied
  };

  static const ratingColorMap = {
    -2: Colors.red,
    -1: Colors.orange,
    0: Colors.amber,
    1: Colors.green,
    2: Colors.blue
  };
}
