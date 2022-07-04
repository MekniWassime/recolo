import 'package:encrypt/encrypt.dart';

class EncryptionUtility {
  EncryptionUtility._();

  static final _iv = IV.fromLength(16);

  static String encrypt({required Key key, required String data}) {
    final encrypter = Encrypter(AES(key));
    if (data.isNotEmpty) {
      return encrypter.encrypt(data, iv: _iv).base64;
    } else {
      return "";
    }
  }

  static String decrypt({required Key key, required String cipher}) {
    final encrypter = Encrypter(AES(key));
    if (cipher.isNotEmpty) {
      return encrypter.decrypt64(cipher, iv: _iv);
    } else {
      return "";
    }
  }

  static Key getKeyFromPassword(String password) {
    int repeatsNeeded = (16 / password.length).floor() + 1;
    password = password * repeatsNeeded;
    assert(
      password.length >= 16,
      "password repeat failed, obtained password length ${password.length}",
    );
    return Key.fromUtf8(password.substring(0, 16));
  }
}
