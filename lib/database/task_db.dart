import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import Task model
import '../models/task.dart';

class TasksDB {
  Database _database;
  final String kTableName = 'ds_phan_anh_da_luu';
  final String kId = 'id_phan_anh';

  Future _openDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'ds_phan_anh_da_luu.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $kTableName($kId INTEGER)');
      },
      version: 1,
    );
  }

  Future insert(Task task) async {
    await _openDB();
    await _database.insert(kTableName, task.toMap());
    print(' inserted !!!!!');
  }

  Future update(Task task) async {
    await _openDB();
    await _database.update(
      kTableName,
      task.toMap(),
      where: '$kId = ?',
      whereArgs: [task.id_phan_anh],
    );
    print(' updated !!!!!!');
  }

  Future delete(int id) async {
    await _openDB();
    print((await _database.delete(
      kTableName,
      where: '$kId = ?',
      whereArgs: [id],
    )));
    print(' deleted !!!!!!');
  }

  Future<List<Task>> getTasks() async {
    await _openDB();
    List<Map<String, dynamic>> maps = await _database.query(kTableName);
    return List.generate(
        maps.length,
        (i) => Task(
              id_phan_anh: maps[i][kId],
            ));
  }
}

