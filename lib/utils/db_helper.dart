import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'words.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE wordsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enword TEXT,
        arword TEXT,
        description TEXT,
        date TEXT,
        favorite BOOLEAN
      )
    ''');
  }

  // Insert
  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database dbClient = await db;
    return await dbClient.insert(table, row);
  }

  // Retrieve
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database dbClient = await db;
    return await dbClient.query(table);
  }

  // Delete
  Future<int> delete(String table,String idColumn,int id) async {
    Database dbClient = await db;
    return await dbClient.delete(table, where: '$idColumn = ?',whereArgs: [id]);
  }

// get in DESC sorting
  Future<List<Map<String, dynamic>>> queryAllOrderBy(String table) async {
    Database dbClient = await db;
    return await dbClient.query(table, orderBy: 'date DESC');
  }

Future<List<Map<String, dynamic>>> queryAllFilterBy(String table, filter) async {
    Database dbClient = await db;
    return await dbClient.query(table, orderBy: 'date DESC', where: 'favorite = 1');
  }


// update values
  Future<int> update(String table, Map<String, dynamic> values, String idColumn, int id) async {
  Database dbClient = await db;
  return await dbClient.update(table, values, where: '$idColumn = ?', whereArgs: [id]);
}

}
