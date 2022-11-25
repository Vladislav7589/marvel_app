import 'package:dio/dio.dart';
import 'package:env_flutter/env_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/src/providers/color_provider.dart';

import '../../constants.dart';
import '../models/heroes.dart';
import '../utils/md5_encode.dart';
import 'database_provider.dart';

final dioProvider = Provider<DioClient>(
  (ref) => DioClient(),
);

final fetchAllHeroesInfo = FutureProvider<List<HeroMarvel>?>((ref) async {
  var data = await ref.watch(dioProvider).getAllHeroesInfo();
  if(data!=null){
    ref.watch(colorProvider.notifier).change(data[0].color);
    ref.watch(insertAllHeroesInfoToDataBase(data));
  }

  return data;
});

final fetchHeroInfo = FutureProvider.family<HeroMarvel, int>((ref, id) async {
  return ref.watch(dioProvider).getHeroInfo(id);
});


class DioClient {
  final Dio dio = Dio();

  Future<HeroMarvel> getHeroInfo(int id) async {
    HeroMarvel hero;
    var ts = DateTime.now();
    var hash = hashGenerator(ts);
    var apikey = dotenv.env['API_KEY'];
    try {
      Response response = await dio.get("$baseUrl/$id", queryParameters: {
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

  Future<List<HeroMarvel>?> getAllHeroesInfo() async {
    List<HeroMarvel> heroes = [];
    DateTime ts = DateTime.now();

    try {
      Response response = await dio.get(baseUrl, queryParameters: {
        'apikey': dotenv.env['API_KEY'],
        'hash': hashGenerator(ts),
        'ts': ts.toString(),
        "limit": amountHeroes.toString(),
        "offset": offset,
      });

      var result = response.data["data"];
      heroes = Heroes.fromJson(result).heroMarvel!;
      for (var hero in heroes) {
        hero.color = hero.imageUrl != null
            ? hero.color =
                await HeroMarvel.updatePaletteGenerator("${hero.imageUrl}")
            : hero.color = backgroundColor.value;
      }
      return heroes;
    } on DioError catch (e) {
      e.response != null
          ? Future.error('Ошибка! Код: ${e.response?.statusCode}')
          : Future.error('Ошибка отправки запроса: \n ${e.message}');
    }
    return null;
  }
}
