import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../models/heroes.dart';
import 'color_provider.dart';

final database = Provider<MyDatabase>((ref) {
  return MyDatabase();
});


final allDataBase = FutureProvider<List<MarvelHeroData>?>((ref) async {
  var data = await ref.read(database).getAllHeroes();
  if(data.isNotEmpty){
    ref.watch(colorProvider.notifier).change(data[0].color);
    return data;
  }
  return null;
});

final dataHero = FutureProvider.family<MarvelHeroData, int>((ref,id) {
  return ref.watch(database).getHero(id);
});

final insertAllHeroesInfoToDataBase = FutureProvider.family<List<HeroMarvel>?, List<HeroMarvel>>((ref,heroes)  {
  ref.read(database).deleteEverything();
  for (var hero in heroes) {
    ref.watch(database).insertHero(hero);
  }
  return null;
});