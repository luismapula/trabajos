import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:path/path.dart';

  class DatabaseHelper {
    static final DatabaseHelper _instance = DatabaseHelper._internal();
    static Database? _database;

    factory DatabaseHelper() {
      return _instance;
    }

    DatabaseHelper._internal();

    Future<Database> get database async {
      if (_database != null) return _database!;
      _database = await _intDatabase();
      return _database!;
    }

    Future<Database> _intDatabase() async {
      String path = join(await getDatabasesPath(), 'my_database.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)'
          );
        },
      );
    }

    Future<void> insertUser (Map<String, dynamic> user) async {
      final db = await database;
      await db.insert('users',user,conflictAlgorithm: ConflictAlgorithm.replace);
    }

    Future<Map<String, dynamic>?> getUser(String username, String password) async {
      final db = await database;
      List<Map<String, dynamic>> results = await db.query (
        'Users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      return results.isNotEmpty ? results.first : null;
    }
  }