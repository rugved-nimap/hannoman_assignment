import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:rugved_assignment/data/models/user_model.dart';
import 'package:rugved_assignment/data/source/locale/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    _db = _db ?? await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, DbHelper.databaseName);

    final database = await openDatabase(
      databasePath,
      version: DbHelper.version,
      onCreate: (db, version) async {
        await db.execute(DbHelper.CREATE_TABLE);
      },
    );

    return database;
  }

  Future<List<UserModel>> getSearchesList() async {
    try {
      List<UserModel> searches = [];
      final db = await database;
      final data = await db.query(DbHelper.tableName, orderBy: '${DbHelper.columnTimeStampName} DESC');

      for (var entry in data) {
        final map = jsonDecode('${entry[DbHelper.columnDataName]}');
        searches.add(UserModel.fromJson(map));
      }
      return searches;
    } catch (e) {
      print("Get data error => $e");
      return [];
    }
  }

  void addSearchToDatabase(int id, String data) async {
    try {
      final db = await database;
      final list = await db.query(DbHelper.tableName, where: 'id = ?', whereArgs: [id]);
      if (list.isNotEmpty) return;

      await db.insert(DbHelper.tableName, {
        DbHelper.columnIdName: id,
        DbHelper.columnDataName: data,
        DbHelper.columnTimeStampName: DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      debugPrint("Add data error => $e");
    }
  }

  void deleteAllSearchesFromDatabase() async {
    try {
      final db = await database;
      await db.delete(DbHelper.tableName);
    } catch (e) {
      debugPrint("Delete all data error => $e");
    }
  }

  void deleteSearchFromDatabase(int id) async {
    try {
      final db = await database;
      await db.delete(DbHelper.tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint("Delete single data error => $e");
    }
  }
}
