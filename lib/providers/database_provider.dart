import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';

final database = Provider<MyDatabase>((ref) {
  return MyDatabase();
});


final allDataBase = FutureProvider<List<MarvelHeroData>>((ref) {
  return ref.watch(database).getAllHeroes();
});

final dataHero = FutureProvider.family<MarvelHeroData, int>((ref,id) {
  return ref.watch(database).getHero(id);
});