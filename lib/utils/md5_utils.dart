import 'dart:convert';

import 'package:crypto/crypto.dart';

String encrypt(String plaintext) {
  final hexDigits = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
  ];
  var encode = utf8.encode(plaintext);
  var md = md5.convert(encode).bytes;
  var l = md.length;
  var str = List(l * 2);
  var k = 0;
  md.forEach((item) {
    str[k++] = hexDigits[item >> 4 & 0xf];
    str[k++] = hexDigits[item & 0xf];
  });
  var pwd = '';
  str.forEach((s) {
    pwd += s;
  });
  return pwd;
}
