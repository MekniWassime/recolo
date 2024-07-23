import 'package:encrypt/encrypt.dart';

class AppConfig {
  AppConfig._();

  static const IV_LENGTH = 16;
  static const AESMode MODE = AESMode.gcm;
  static const HASH_ALGORITHM = "HmacSha256";
}
