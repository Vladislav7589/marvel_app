

import 'package:dio/dio.dart';
import 'package:env_flutter/env_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/providers/color_provider.dart';
import '../constants.dart';
import '../database/database.dart';
import '../models/hero_marvel.dart';
import '../utils/md5_encode.dart';
import 'database_provider.dart';

final dioProvider = Provider<DioClient>(
      (ref) => DioClient(),
);

final fetchAllHeroesInfo = FutureProvider.family<List<HeroMarvel>? , WidgetRef >(
        (ref, widgetRef ) async {
      return ref.watch(dioProvider).getAllHeroesInfo(widgetRef);
    });

final fetchHeroInfo = FutureProvider.family<HeroMarvel , int >(
        (ref, id ) async {
      return ref.watch(dioProvider).getHeroInfo(id);
    });


class DioClient  {
  final Dio dio = Dio();

  Future insertAllHeroesInfoToDataBase(List<HeroMarvel> heroes, MyDatabase database) async {
    database.deleteEverything();
    for (var hero in heroes) {
      database.insertHero(hero);
    }
  }

  Future<HeroMarvel> getHeroInfo(int id) async {
    HeroMarvel hero;
    var ts = DateTime.now();
    var hash = hashGenerator(ts);
    var apikey = dotenv.env['API_KEY'];
    try {

      Response response = await dio.get("$baseUrl/$id",
          queryParameters: {
            'apikey': apikey,
            'hash': hash,
            'ts': ts.toString(),
          });
      var result = response.data["data"]["results"][0];
      hero = HeroMarvel.fromJson(result);

      return hero;

    } on DioError catch (e) {

      if (e.response != null) {
        return Future.error('Ошибка! Код: ${e.response?.statusCode}');
      } else {
        return Future.error('Ошибка отправки запроса: \n ${e.message}');
      }
    }
  }


  Future<List<HeroMarvel>?> getAllHeroesInfo(WidgetRef ref) async {

    List<HeroMarvel> heroes = [];
    DateTime ts = DateTime.now();

    try {
      Response response = await dio.get(baseUrl,
          queryParameters: {
            'apikey': dotenv.env['API_KEY'],
            'hash': hashGenerator(ts),
            'ts': ts.toString(),
            "limit": amountHeroes.toString(),
            "offset": offset,
          });

      var result = response.data["data"];
      heroes = Heroes.fromJson(result).heroMarvel!;
      for (var hero in heroes){
        hero.color = hero.imageUrl != null ? hero.color = await HeroMarvel.updatePaletteGenerator("${hero.imageUrl}"): hero.color = backgroundColor.value ;
      }
      ref.watch(colorProvider.notifier).change(heroes[0].color!);

      insertAllHeroesInfoToDataBase(heroes, ref.watch(database));
      return heroes;

    } on DioError catch (e) {
      e.response != null
          ? Future.error('Ошибка! Код: ${e.response?.statusCode}')
          :  Future.error('Ошибка отправки запроса: \n ${e.message}');

    }
    return null;

  }
}
