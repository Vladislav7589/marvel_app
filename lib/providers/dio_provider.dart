
import 'package:dio/dio.dart';
import 'package:env_flutter/env_flutter.dart';
import 'package:marvel_app/providers/color_provider.dart';
import '../constants.dart';
import '../database/database.dart';
import '../models/hero_marvel.dart';
import '../utils/md5.dart';

class DioProvider  {
  final Dio dio = Dio();

  Future insertAllHeroesInfoToDataBase(List<HeroMarvel> heroes, MyDatabase database) async {
    database.deleteEverything();
    for (var hero in heroes) {
      database.insertHero(hero);
    }
    final all = await database.select(database.marvelHero).get();
    for(var hero in all) {
      print('${hero.id}');
    }
    //print(database.);
  }
  late List<HeroMarvel> heroes;

  Future<List<int>?> getIDHeroes() async {
    loadingState = LoadingState.loading;
    List<int>? idHeroes = [];
    var ts = DateTime.now();
    var hash = hashGenerator(ts);
    var apikey = dotenv.env['API_KEY'];
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
      loadingState = LoadingState.successfully;
      return idHeroes;
    } on DioError catch (e) {
      loadingState = LoadingState.error;

      e.response != null
          ? Future.error('Ошибка! Код: ${e.response?.statusCode}')
          :  Future.error('Ошибка отправки запроса: \n ${e.message}');

    }
    return null;
  }

  Future<HeroMarvel> getHeroInfo(int id) async {
    HeroMarvel hero;
    var ts = DateTime.now();
    var hash = hashGenerator(ts);
    var apikey = dotenv.env['API_KEY'];
    try {
      loadingState = LoadingState.loading;
      Response response = await dio.get("$baseUrl/$id",
          queryParameters: {
            'apikey': apikey,
            'hash': hash,
            'ts': ts.toString(),
          });
      var result = response.data["data"]["results"][0];
      hero = HeroMarvel.fromJson(result);
      hero.imageUrl != null ? hero.color = await HeroMarvel.updatePaletteGenerator("${hero.imageUrl}"): hero.color = backgroundColor.value ;

      return hero;

    } on DioError catch (e) {

      if (e.response != null) {
        return Future.error('Ошибка! Код: ${e.response?.statusCode}');
      } else {
        return Future.error('Ошибка отправки запроса: \n ${e.message}');
      }
    }
  }


  Future <List<HeroMarvel>> getAllHeroesInfo(List<int>? listHeroes, ColorProvider colorState, MyDatabase db) async {
    List<HeroMarvel> heroes = [];
    for (var id in listHeroes!) {
      heroes.add(await getHeroInfo(id));

    }
    /*colorState.color = heroes[0].color!;
    colorState.update();*/
    insertAllHeroesInfoToDataBase(heroes, db);
    return heroes;
  }
}
