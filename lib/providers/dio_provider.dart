
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:marvel_app/providers/color_provider.dart';
import '../constants.dart';
import '../models/hero_marvel.dart';


class DioProvider  {
  final Dio dio = Dio();
  late List<HeroMarvel> heroes;

  Future<List<int>?> getIDHeroes() async {
    List<int>? idHeroes = [];
    try {
      Response response = await dio.get(baseUrl,
          queryParameters: {
            'apikey': apikey,
            'hash': hash,
            'ts': ts.toString(),
            "limit": amountHeroes.toString(),
            "offset": offset,
          });

      var result = response.data["data"]["results"];
      for (var id in result) {
        idHeroes.add(id["id"]);
      }
      //log('Успешно получены $amountHeroes');
      return idHeroes;
    } on DioError catch (e) {
      e.response != null
          ? log('Ошибка! Код: ${e.response?.statusCode}')
          : log('Ошибка отправки запроса: \n ${e.message}');

    }
  }

  Future<HeroMarvel> getHeroInfo(int id) async {
    HeroMarvel hero;

    try {
      Response response = await dio.get("$baseUrl/$id",
          queryParameters: {
            'apikey': apikey,
            'hash': hash,
            'ts': ts.toString(),
          });
      var result = response.data["data"]["results"][0];
      hero = HeroMarvel.fromJson(result);
      hero.imageUrl != null ? hero.color = await HeroMarvel.updatePaletteGenerator("${hero.imageUrl}"): hero.color = backgroundColor ;

      return hero;

    } on DioError catch (e) {

      if (e.response != null) {
        return Future.error('Ошибка! Код: ${e.response?.statusCode}');
      } else {
        return Future.error('Ошибка отправки запроса: \n ${e.message}');
      }
    }
  }

  Future <List<HeroMarvel>> getAllHeroesInfo(List<int> listHeroes, ColorProvider colorState) async {
    List<HeroMarvel> heroes = [];
      for (var id in listHeroes) {
        heroes.add(await getHeroInfo(id));
        //log('Успешно получена информация $id героя');
      }
      colorState.color = heroes[0].color!;
      colorState.update();
      return heroes;

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
}
