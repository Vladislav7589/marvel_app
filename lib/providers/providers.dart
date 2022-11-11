

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import '../models/hero_marvel.dart';
import 'color_provider.dart';
import 'dio_provider.dart';

final dio = Provider<DioProvider>(
      (ref) => DioProvider(),
);

final colorProvider = ChangeNotifierProvider(
      (ref) => ColorProvider(),
);

final fetchIdHeroes = FutureProvider<List<int>?>((ref) async {
  return ref.watch(dio).getIDHeroes();
});
final database = Provider<MyDatabase>((ref) {
  return MyDatabase();
});

final DBData = FutureProvider<List<MarvelHeroData>>((ref) {
  return ref.watch(database).getAllHeroes();
});
