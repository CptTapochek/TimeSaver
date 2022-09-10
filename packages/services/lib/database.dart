import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:services/data_models/dbCategories.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  static final DBProvider db = DBProvider();
  Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "Test6.db");
    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Categories("
              "id INTEGER PRIMARY KEY, "
              "indexCategory INTEGER, "
              "title TEXT, "
              "time INTEGER, "
              "color TEXT, "
              "icon TEXT, "
              "type TEXT, "
              "min INTEGER, "
              "max INTEGER"
          ")"
      );
    });
  }

  addCategory(DBCategories categories) async {
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT INTO Categories(id, indexCategory, title, time, color, icon, type, min, max) "
      "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [categories.id, categories.indexCategory, categories.title, categories.time, categories.color, categories.icon,
      categories.type, categories.min, categories.max]
    );
    return raw;
  }

  Future<List<DBCategories>> getAllCategories() async {
    final db = await database;
    var res = await db.query("Categories");
    List<DBCategories> list = res.isNotEmpty ? res.map((e) => DBCategories.fromMap(e)).toList() : [];

    return list;
  }
}