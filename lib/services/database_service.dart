import 'dart:convert';

import 'package:path/path.dart';
import 'package:rugved_assignment/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  final String _databaseName = "hanooman";
  final String _tableName = "search_table";
  final String _columnIdName = "id";
  final String _columnDataName = "data";
  final String _columnTimeStampName = "timeStamp";

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, _databaseName);

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnIdName INTEGER PRIMARY KEY,
            $_columnDataName TEXT NOT NULL,
            $_columnTimeStampName INTEGER NOT NULL
          )
          ''');
      },
    );

    return database;
  }

  Future<List<UserModel>> getSearchesList() async {
    final db = await database;
    final data = await db.query(_tableName, orderBy: '$_columnTimeStampName DESC');
    List<UserModel> searches = data.map((element) => UserModel.fromJson(jsonDecode(element[_columnDataName] as String))).toList();
    return searches;
  }

  void addSearchToDatabase(int id, String data) async {
    final db = await database;
    final list = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (list.isNotEmpty) return;

    await db.insert(_tableName, {
      _columnIdName: id,
      _columnDataName: data,
      _columnTimeStampName: DateTime.now().millisecondsSinceEpoch,
    });
  }

  void deleteAllSearchesFromDatabase() async {
    final db = await database;
    await db.delete(_tableName);
  }

  void deleteSearchFromDatabase(int id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
