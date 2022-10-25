
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


import '../constants.dart';
import '../models/hero_marvel.dart';



class DioProvider extends ChangeNotifier {
  final Dio dio = Dio();


  Future<List<int>?> getHeroes() async {
    List<int>? idHeroes = [];
    try {
      Response response = await dio.get(baseUrl,
          queryParameters: {
            'apikey': apikey,
            'hash': hash,
            'ts': ts.toString(),
            "limit": amountHeroes.toString(),
          });
      // print('Body: ${response.data}');
      var result = response.data["data"]["results"];
      for (var id in result) {
        idHeroes.add(id["id"]);
      }
      //log('Успешно получены Id героев');
      //log('${result.length}');
      return idHeroes;
    } on DioError catch (e) {
      e.response != null
          ? log('Ошибка! Код: ${e.response?.statusCode}')
          : log('Ошибка отправки запроса: \n ${e.message}');
    }
  }

/*  Future<List<HeroMarvel>?> getHeroesInfo(List<int> heroes) async {
    List<HeroMarvel>? heroesInfo;
    try {
      for (var id in heroes) {
        Response response = await dio.get("$baseUrl/$id",
            queryParameters: {
              'apikey': apikey,
              'hash': hash,
              'ts': ts.toString(),
            });
        var hero = response.data["data"]["results"][0];
        heroesInfo = List<HeroMarvel>.from(hero.map((model)=> HeroMarvel.fromJson(model)));
      }
       print('Body: $heroesInfo');

       log('Успешно получены данные всех ${heroesInfo.length} героев');
        return heroesInfo;
    } on DioError catch (e) {
      log("${e.response?.realUri}");
      if( e.response != null) return Future.error('Ошибка! Код: ${e.response?.statusCode}');
      else return Future.error('Ошибка отправки запроса: \n ${e.message}');
    }
  }*/

  Future<HeroMarvel?> getHeroInfo(int id) async {
    try {
      Response response = await dio.get("$baseUrl/$id",
          queryParameters: {
            'apikey': apikey,
            'hash': hash,
            'ts': ts.toString(),
          });
      //print('Body: ${response.data}');
      var hero = response.data["data"]["results"][0];

      HeroMarvel heroColor;
      heroColor = HeroMarvel.fromJson(hero);
      heroColor.color = await HeroMarvel.updatePaletteGenerator(heroColor.imageUrl?? " ");
      print(heroColor.color);
      //log('Успешно получены id $id');
      return heroColor;
    } on DioError catch (e) {
      log("${e.response?.realUri}");
      if (e.response != null)
        return Future.error('Ошибка! Код: ${e.response?.statusCode}');
      else
        return Future.error('Ошибка отправки запроса: \n ${e.message}');
    }
  }

}
