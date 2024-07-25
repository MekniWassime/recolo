import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptionUtility {
  EncryptionUtility._();

  static String encrypt(String data,
      {required Key key, required IV iv, required AESMode mode}) {
    if (data.isEmpty) return "";
    final encrypter = Encrypter(AES(key, mode: mode));
    return encrypter.encrypt(data, iv: iv).base64;
  }

  static String decrypt(
    String data, {
    required Key key,
    required IV iv,
    required AESMode mode,
  }) {
    if (data.isEmpty) return "";
    final encrypter = Encrypter(AES(key, mode: mode));
    return encrypter.decrypt64(data, iv: iv);
  }

  static Key kdf(String password) {
    if (password.isEmpty) throw Exception("Password cannot be empty");
    final saltedPassword = password + dotenv.get("PASSWORD_SALT");
    final hashedPassword = hashBase64(saltedPassword, hash: sha256);
    return Key.fromBase64(hashedPassword);
  }

  static String hashBase64(
    String data, {
    Hash hash = sha512,
  }) {
    final hmacSha256 = Hmac(hash, utf8.encode(dotenv.get("HMAC_SHA256_KEY")));
    return base64.encode(hmacSha256.convert(utf8.encode(data)).bytes);
  }

  static AESMode modeFromString(String value) =>
      AESMode.values.firstWhere((mode) => mode.toString() == value);
}
