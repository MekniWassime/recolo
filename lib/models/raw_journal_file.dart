import 'package:flutter/foundation.dart';
import 'package:recolo/models/journal_metadata.dart';
import 'package:recolo/models/raw_journal_headers.dart';

/// File data before password decryption
class RawJournalFile {
  final JournalMetadata metadata;
  final RawJournalHeaders rawHeaders;
  final String encryptedData;

  const RawJournalFile({
    required this.rawHeaders,
    required this.encryptedData,
    required this.metadata,
  });

  // SERIALIZATION //

  dynamic toJson() => {
        "metadata": metadata.toJson(),
        "headers": rawHeaders.toJson(),
        "data": encryptedData,
      };

  factory RawJournalFile.fromJson(dynamic json) {
    return RawJournalFile(
      metadata: JournalMetadata.fromJson(json["metadata"]),
      rawHeaders: RawJournalHeaders.fromJson(json["headers"]),
      encryptedData: json["data"],
    );
  }
}
