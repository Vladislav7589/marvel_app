import 'dart:convert';
import 'package:dio/dio.dart';


Future<String> imageToBase64(String imageUrl) async {
  Dio dio = Dio();
  Response response = await dio.get(imageUrl,options: Options(responseType: ResponseType.bytes));
  final bytes = response.data;
  return base64Encode(bytes);
}

