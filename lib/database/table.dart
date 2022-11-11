import 'package:drift/drift.dart';

class MarvelHero extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().named('name')();
  TextColumn get description => text().named('description')();
  TextColumn get image => text().named('image')();
  IntColumn get color => integer().named('color')();
}
