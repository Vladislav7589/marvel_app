
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:env_flutter/env_flutter.dart';

String hashGenerator(DateTime ts) {

  var apiKey =  dotenv.env['API_KEY'];
  var privateKey = dotenv.env['SECRET_KEY'];

  String md5 = ts.toString() + privateKey! + apiKey!;
  return generateMd5(md5);
}

String generateMd5(String input) => md5.convert(utf8.encode(input)).toString();

