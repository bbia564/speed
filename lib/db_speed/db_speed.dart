import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:get_speed/db_speed/speed_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBSpeed extends GetxService {
  late Database dbBase;
  final faker = Faker();

  Future<DBSpeed> init() async {
    await createSpeedDB();
    return this;
  }

  createSpeedDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'speed.db');
    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createSpeedTable(db);
          await _initData(db);
        });
  }

  createSpeedTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS speed (id INTEGER PRIMARY KEY, created_time TEXT, type INTEGER, speed INTEGER)');
  }

  _initData(Database db) async {
    for (int i = 0; i < 15; i++) {
      await db.insert('speed', {
        'created_time': DateTime.now().subtract(Duration(days: i+1)).toIso8601String(),
        'type': faker.randomGenerator.integer(4),
        'speed': faker.randomGenerator.integer(20),
      });
    }
  }

  cleanAllData() async {
    await dbBase.delete('speed');
  }

  Future<List<SpeedEntity>> getAllData() async {
    var result = await dbBase.query('speed', orderBy: 'created_time DESC');
    return result.map((e) => SpeedEntity.fromJson(e)).toList();
  }
}
