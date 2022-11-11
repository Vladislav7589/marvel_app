import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:marvel_app/database/table.dart';
import 'package:marvel_app/models/hero_marvel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'heroes.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [MarvelHero])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<MarvelHeroData>> getAllHeroes() async {
    return await select(marvelHero).get();
  }

  Future<int> insertHero(HeroMarvel hero) async {
    return await into(marvelHero).insert(
        MarvelHeroCompanion.insert(
        description: "${hero.description}",
        id: hero.id!,
        name: hero.name!,
        image:  await imageToBase64("${hero.imageUrl}"),
        color: hero.color!)
    );
  }
  Future<void> deleteEverything() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

Future<String> imageToBase64(String imageUrl) async {
  Uri url = Uri.parse(imageUrl);
  http.Response response = await http.get(url);
  final bytes = response.bodyBytes;

  return base64Encode(bytes);
}
