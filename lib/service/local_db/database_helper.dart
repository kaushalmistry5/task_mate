import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _appDataBase = DatabaseHelper._internal();

  factory DatabaseHelper() => _appDataBase;
  DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDataBase();
    if (kDebugMode) {
      print("database is running");
    }

    return _database!;
  }

  Future<Database> _initDataBase() async{
    print("Database created");
    final databasepath = await getDatabasesPath();

    final path = join(databasepath, 'todo_database.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),

    );
  }

  Future<void> _onCreate(Database db, int version) async {
    if (kDebugMode) {
      print("database Created");
    }
    await db.execute(
      'CREATE TABLE task(taskId INTEGER PRIMARY KEY, title TEXT, date TEXT, task_des TEXT)',
    );
  }

  Future<void> insertUser(Task task) async {

    final db = await _appDataBase.database;

    await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String,dynamic>>> fetchAllTask() async{
    final db = await _appDataBase.database;

    List<Map<String,dynamic>> result = await db.rawQuery("SELECT * FROM task");
    print("Data is $result");
    return result;
  }

  Future<int> updateTask(Task task) async{
    try {
      print("TaskId is: ${task.taskId}");
      print("Title is: ${task.title}");
      print("Date is: ${task.date}");
      print("TaskDes is: ${task.taskDes}");

      final db = await _appDataBase.database;
      await db.rawUpdate("UPDATE task SET title = ?, date = ?, task_des = ? WHERE taskId = ?;",[task.title, task.date,task.taskDes,task.taskId]);
      //await db.execute("UPDATE task SET date = ${task.date}, task_des = ${task.taskDes} WHERE taskId = ${task.taskId};");
      return 1;
  }
    catch(e){
      return 0;
    }
  }

  Future<int> deleteTask(Task task) async{
    try {
      final db = await _appDataBase.database;
      await db.rawDelete("DELETE FROM task WHERE taskId = ${task.taskId}");
      return 1;
    }
    catch(e){
      return 0;
    }
  }


}

//statemanager provider
//improve the ui
//counter app, provider, main ma intialize== multiprovider
//seprte class counterprovider, counter variable intialize
//get method
//increment mate ek fuction
//text widget provider, consumer initialize, provider class link
//plus button onpress par provider par call karavno

