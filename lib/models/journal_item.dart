import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:recolo/constants/verify.dart';
import 'package:recolo/models/journal_metadata.dart';
import 'package:recolo/utility/encryption_utility.dart';

class JournalItem {
  final JournalMetadata metadata;
  final String data;
  final Key key;
  final int version = 1;

  JournalItem({
    required this.metadata,
    required this.data,
    required String password,
  }) : key = EncryptionUtility.getKeyFromPassword(password);

  JournalItem.withKey({
    required this.metadata,
    required this.data,
    required this.key,
  });

  String get fileName => metadata.fileName;
  String get title => metadata.title;
  int get rating => metadata.rating;
  DateTime get date => metadata.date;

  String toJsonString() {
    var object = {
      "fileName": metadata.fileName,
      "date": metadata.date.toIso8601String(),
      "rating": metadata.rating,
      "title": metadata.title,
      "encodedData": EncryptionUtility.encrypt(
        key: key,
        data: data,
      ),
      "encVerify": EncryptionUtility.encrypt(
        key: key,
        data: getVerifString(metadata.date),
      ),
      "version": version
    };
    return jsonEncode(object);
  }

  JournalItem copyWith({
    String? newData,
    String? newTitle,
    int? newRating,
  }) {
    return JournalItem.withKey(
      key: key,
      data: newData ?? data,
      metadata: metadata.copyWith(
        newTitle: newTitle,
        newRating: newRating,
      ),
    );
  }

  static Future<JournalItem> fromFile(File file, String password) async {
    final jsonFileContent = jsonDecode(await file.readAsString());
    final key = EncryptionUtility.getKeyFromPassword(password);
    final date = DateTime.parse(jsonFileContent['date']);

    var encVerifString = EncryptionUtility.decrypt(
      key: key,
      cipher: jsonFileContent['encVerify'],
    );
    if (encVerifString != getVerifString(date)) {
      throw WrongDecryptionKeyException("icorrect password or corrupted data");
    }
    return JournalItem(
      data: EncryptionUtility.decrypt(
        key: key,
        cipher: jsonFileContent["encodedData"],
      ),
      metadata: JournalMetadata(
        rating: jsonFileContent['rating'],
        date: date,
        title: jsonFileContent['title'],
      ),
      password: password,
    );
  }
}

class WrongDecryptionKeyException implements Exception {
  final String message;

  WrongDecryptionKeyException([this.message = ""]);

  @override
  String toString() {
    return "WrongDecryptionKeyException: $message";
  }
}
