import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:recolo/constants/app_config.dart';
import 'package:recolo/models/journal_headers.dart';
import 'package:recolo/models/journal_metadata.dart';
import 'package:recolo/models/raw_journal_file.dart';
import 'package:recolo/utility/encryption_utility.dart';

class JournalItem {
  final JournalMetadata metadata;
  final JournalHeaders headers;
  final String data;
  final encrypt.Key key;
  final int version = 1;

  JournalItem({
    required this.metadata,
    required this.headers,
    required this.data,
    required this.key,
  });

  // UTILITY //

  static Future<JournalItem> fromFile(File file, String password) async {
    final jsonFileContent = jsonDecode(await file.readAsString());
    final raw = RawJournalFile.fromJson(jsonFileContent);
    return JournalItem.fromRaw(raw: raw, key: EncryptionUtility.kdf(password));
  }

  JournalItem copyWith({
    String? newData,
    String? newTitle,
    int? newRating,
  }) {
    final iv = encrypt.IV.fromLength(AppConfig.IV_LENGTH);
    return JournalItem(
      key: key,
      headers: headers.copyWith(iv: iv),
      data: newData ?? data,
      metadata: metadata.copyWith(
        newTitle: newTitle,
        newRating: newRating,
      ),
    );
  }

  factory JournalItem.empty({
    required JournalMetadata metadata,
    required encrypt.Key key,
  }) {
    return JournalItem(
      metadata: metadata,
      headers: JournalHeaders.empty(),
      data: "",
      key: key,
    );
  }

  // SERIALIZATION //

  RawJournalFile toRaw() {
    final hash = EncryptionUtility.hashBase64(data);
    final encryptedData = EncryptionUtility.encrypt(data,
        key: key, mode: headers.encryptionAlgorithm, iv: headers.iv);
    return RawJournalFile(
      rawHeaders: headers.toRaw(hash: hash, key: key),
      encryptedData: encryptedData,
      metadata: metadata,
    );
  }

  factory JournalItem.fromRaw(
      {required RawJournalFile raw, required encrypt.Key key}) {
    final data = EncryptionUtility.decrypt(raw.encryptedData,
        key: key,
        mode: raw.rawHeaders.encryptionAlgorithm,
        iv: raw.rawHeaders.iv);
    final headers = JournalHeaders.fromRaw(raw: raw.rawHeaders, key: key);
    final dataHash = EncryptionUtility.hashBase64(data);
    if (headers.hash != dataHash)
      throw WrongDecryptionKeyException("hash does not match");
    return JournalItem(
      metadata: raw.metadata,
      headers: headers,
      data: data,
      key: key,
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
