import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:memories/data/type_conversion.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Memories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get emoji => text()(); // e.g. "😊", "😔"
  DateTimeColumn get date => dateTime()(); // e.g. "😊", "😔"
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get imagePaths =>
      text().map(const StringListConverter())(); // JSON string list
}

@DriftDatabase(tables: [Memories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // QUERIES / DAO-ish
  Stream<List<Memory>> watchAll() =>
      (select(memories)..orderBy([(m) => OrderingTerm.desc(m.date)])).watch();

  Future<int> insertMemory(MemoriesCompanion data) {
    print(data);
    return into(memories).insert(data);
  }

  Future updateMemory(Memory row) => update(memories).replace(row);

  Future deleteMemory(int id) =>
      (delete(memories)..where((tbl) => tbl.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'memories.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
