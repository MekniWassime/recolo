import 'package:encrypt/encrypt.dart';
import 'package:recolo/constants/app_config.dart';
import 'package:recolo/models/raw_journal_headers.dart';
import 'package:recolo/utility/encryption_utility.dart';

class JournalHeaders {
  final IV iv;
  final AESMode encryptionAlgorithm;
  final String hash;
  final String hashAlgorithm;

  const JournalHeaders({
    required this.iv,
    required this.encryptionAlgorithm,
    required this.hash,
    required this.hashAlgorithm,
  });

  // UTILITY //

  JournalHeaders copyWith({IV? iv}) => JournalHeaders(
        iv: iv ?? this.iv,
        encryptionAlgorithm: encryptionAlgorithm,
        hash: hash,
        hashAlgorithm: hashAlgorithm,
      );

  factory JournalHeaders.empty() {
    final iv = IV.fromLength(16);
    return JournalHeaders(
      iv: iv,
      encryptionAlgorithm: AppConfig.MODE,
      hash: "",
      hashAlgorithm: AppConfig.HASH_ALGORITHM,
    );
  }

  // SERIALIZATION //

  RawJournalHeaders toRaw({required String hash, required Key key}) {
    final encryptedHash = EncryptionUtility.encrypt(
      key: key,
      data: hash,
      iv: iv,
      mode: encryptionAlgorithm,
    );
    return RawJournalHeaders(
      encryptionAlgorithm: encryptionAlgorithm,
      encryptedHash: encryptedHash,
      iv: iv,
      hashAlgorithm: hashAlgorithm,
    );
  }

  factory JournalHeaders.fromRaw(
      {required RawJournalHeaders raw, required Key key}) {
    final hash = EncryptionUtility.decrypt(
      key: key,
      iv: raw.iv,
      mode: raw.encryptionAlgorithm,
      cipher: raw.encryptedHash,
    );
    return JournalHeaders(
      hash: hash,
      iv: raw.iv,
      encryptionAlgorithm: raw.encryptionAlgorithm,
      hashAlgorithm: raw.hashAlgorithm,
    );
  }
}
