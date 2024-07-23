import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class JournalMetadata {
  final int rating; //-2, -1, 0, 1, 2
  final DateTime date;
  final String title;

  get fileName => "${date.millisecondsSinceEpoch}.json";

  JournalMetadata({
    required this.date,
    this.rating = 0,
    this.title = "",
  }) : assert(rating >= -2 && rating <= 2, "value $rating is invalid");

  // UTILITY //

  static Future<JournalMetadata> fromFile(File file) async {
    final jsonFileContent = jsonDecode(await file.readAsString());
    return JournalMetadata.fromJson(jsonFileContent["metadata"]);
  }

  JournalMetadata copyWith({String? newTitle, int? newRating}) {
    return JournalMetadata(
      rating: newRating ?? rating,
      date: date,
      title: newTitle ?? title,
    );
  }

  // SERIALIZATION //

  dynamic toJson() => {
        "rating": rating,
        "date": date.toIso8601String(),
        "title": title,
      };

  factory JournalMetadata.fromJson(dynamic json) => JournalMetadata(
        rating: json['rating'],
        date: DateTime.parse(json['date']),
        title: json['title'],
      );

  // MISC //

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
