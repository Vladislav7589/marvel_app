import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import 'color_provider.dart';

final database = Provider<MyDatabase>((ref) {
  return MyDatabase();
});


final allDataBase = FutureProvider<List<MarvelHeroData>>((ref) async {
  var data = await ref.watch(database).getAllHeroes();
  ref.watch(colorProvider.notifier).change(data[0].color);
  return ref.watch(database).getAllHeroes();
});

final dataHero = FutureProvider.family<MarvelHeroData, int>((ref,id) {
  return ref.watch(database).getHero(id);
});