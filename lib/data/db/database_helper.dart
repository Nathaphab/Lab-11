import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    _database ??= await _initDB("event_app.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {

    await db.execute('''
CREATE TABLE categories(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
color_hex TEXT,
icon_key TEXT
)
''');

    await db.execute('''
CREATE TABLE events(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT,
description TEXT,
category_id INTEGER,
event_date TEXT,
start_time TEXT,
end_time TEXT,
status TEXT,
priority INTEGER
)
''');

    await db.execute('''
CREATE TABLE reminders(
id INTEGER PRIMARY KEY AUTOINCREMENT,
event_id INTEGER,
minutes_before INTEGER,
remind_at TEXT,
is_enabled INTEGER
)
''');
  }
}