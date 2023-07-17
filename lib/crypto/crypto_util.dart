import 'dart:convert';

import 'package:crypto/crypto.dart' as cry;

extension CryptoUtils on String {
  String get encodeMd5 => cry.md5.convert(utf8.encode(this)).toString();
  String get encodeSHA1 => cry.sha1.convert(utf8.encode(this)).toString();
  String get encodeSHA256 => cry.sha256.convert(utf8.encode(this)).toString();
}
