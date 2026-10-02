import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mine_safety.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final dbs = join(dbPath.path, filePath);

    return await openDatabase(
      dbs,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employeeId TEXT UNIQUE,
        name TEXT,
        mineLocation TEXT,
        language TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE modules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employeeId TEXT,
        moduleId TEXT,
        isCompleted INTEGER,
        score INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE certificates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        certificateId TEXT UNIQUE,
        employeeId TEXT,
        issueDate TEXT,
        modulesList TEXT,
        isSynced INTEGER
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}