import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' as foundation;

class EncryptionUtility {
  EncryptionUtility._();

  static String encrypt({
    required Key key,
    required String data,
    required IV iv,
    required AESMode mode,
  }) {
    final encrypter = Encrypter(AES(key, mode: mode));
    if (data.isNotEmpty) {
      return encrypter.encrypt(data, iv: iv).base64;
    } else {
      return "";
    }
  }

  static String decrypt({
    required Key key,
    required String cipher,
    required IV iv,
    required AESMode mode,
  }) {
    final encrypter = Encrypter(AES(key, mode: mode));
    if (cipher.isNotEmpty) {
      return encrypter.decrypt64(cipher, iv: iv);
    } else {
      return "";
    }
  }

  //TODO use dotenv Password Salt
  static Key kdf(String password) {
    final saltedPassword = password +
        "98747a7d30bd79a183c92529b4be440176ff744d94ce1ce608ad7f74d83d4ad6";
    final hashedPassword = hash(data: saltedPassword, hash: sha256);
    return Key.fromBase64(hashedPassword);
  }

  static String hash({
    required String data,
    Hash hash = sha512,
  }) {
    //TODO use dotenv Hash Key
    final hmacSha256 = Hmac(
        hash,
        utf8.encode(
          "fab7d50781a47913a8869d191c48e793592aeee3165f639a1496a1588e78a4c3",
        ));
    if (data.isNotEmpty) {
      return base64.encode(hmacSha256.convert(utf8.encode(data)).bytes);
    } else {
      return "";
    }
  }

  // static Key getKeyFromPassword(String password) {
  //   int repeatsNeeded = (16 / password.length).floor() + 1;
  //   password = password * repeatsNeeded;
  //   assert(
  //     password.length >= 16,
  //     "password repeat failed, obtained password length ${password.length}",
  //   );
  //   return Key.fromUtf8(password.substring(0, 16));
  // }

  static AESMode modeFromString(String value) =>
      AESMode.values.firstWhere((mode) => mode.toString() == value);
}
