import 'dart:developer';

import 'package:advance_flutter_exam/model/db_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();

  Database? database;

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "database.db");
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query = """
          CREATE TABLE IF NOT EXISTS tododiary (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          time TEXT NOT NULL
        );
        """;
        await db.execute(query);
        log("Database created succesfully...");
      },
    );
  }

  Future<int?> insertData(
      {required String time,
      required String title,
      required BuildContext context}) async {
    if (database == null) {
      await initDB();
    } else {
      String query1 = """
        SELECT * FROM tododiary WHERE time=?;
      """;

      List query1args = [
        time,
      ];

      List<Map<String, dynamic>>? data =
          await database?.rawQuery(query1, query1args);

      if (data!.isNotEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text("Already Task Avialable..."),
              backgroundColor: Colors.green,
            ),
          );
        return 0;
      } else {
        List args = [title, time];
        String query = """
        INSERT INTO tododiary(name,time) 
        VALUES (?,?);
      """;
        return await database?.rawInsert(query, args);
      }
    }
    return null;
  }

  fetchData() async {
    if (database == null) {
      await initDB();
    } else {
      String query = """
        SELECT * FROM tododiary;
      """;

      List<Map<String, dynamic>>? rawData = await database?.rawQuery(query);

      List<DbModel> finalData =
          rawData!.map((e) => DbModel.fromMap(map: e)).toList();
      return finalData;
    }
    return null;
  }
}
