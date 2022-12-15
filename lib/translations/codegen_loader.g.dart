// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "mainText": "Choose your hero",
  "missing": "Missing",
  "notification": {
    "button": "Check"
  },
  "connection": {
    "connected": "Connected",
    "swipeConnection": "Swipe down to update",
    "notConnected": "No internet connection or other error"
  },
  "errors": {
    "errorLoadData": "Load data error",
    "errorLoadDatabase": "Load database error"
  }
};
static const Map<String,dynamic> ru = {
  "mainText": "Выбери своего героя",
  "missing": "Отсутствует",
  "notification": {
    "button": "Смотреть"
  },
  "connection": {
    "connected": "Подключено",
    "swipeConnection": "Проведите вниз чтобы обновить",
    "notConnected": "Отсутствует интернет соединение или возникла другая ошибка"
  },
  "errors": {
    "errorLoadData": "Ошибка загрузки данных",
    "errorLoadDatabase": "Ошибка загрузки локальных данных"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
