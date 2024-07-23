import 'package:encrypt/encrypt.dart';
import 'package:recolo/utility/encryption_utility.dart';

class RawJournalHeaders {
  final IV iv;
  final AESMode encryptionAlgorithm;
  final String encryptedHash;
  final String hashAlgorithm;

  const RawJournalHeaders({
    required this.encryptionAlgorithm,
    required this.encryptedHash,
    this.hashAlgorithm = "HmacSha256",
    required this.iv,
  });

  // SERIALIZATION //

  dynamic toJson() => {
        "iv": iv.base64,
        "encryptionAlgorithm": encryptionAlgorithm.toString(),
        "encryptedHash": encryptedHash,
        "hashAlgorithm": hashAlgorithm,
      };

  factory RawJournalHeaders.fromJson(dynamic json) => RawJournalHeaders(
        iv: IV.fromBase64(json["iv"]),
        encryptionAlgorithm:
            EncryptionUtility.modeFromString(json["encryptionAlgorithm"]),
        encryptedHash: json["encryptedHash"],
        hashAlgorithm: json["hashAlgorithm"],
      );
}
