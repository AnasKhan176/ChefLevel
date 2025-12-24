import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE preferences (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            food TEXT
          )
        ''');
      },
    );
  }
}