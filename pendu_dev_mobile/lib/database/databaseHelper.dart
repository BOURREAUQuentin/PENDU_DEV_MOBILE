import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/score.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pendu.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE pendu(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pseudo TEXT,
          level INTEGER,
          essai INTEGER
        )
      ''');
  }

  Future<int> insertScore(String pseudo, int level, int essai) async {
    final db = await instance.database;
    return await db.insert(
      'pendu',
      {'pseudo': pseudo, 'level': level, 'essai': essai},
    );
  }

  Future<List<Score>> getScore() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('pendu');

    return List.generate(maps.length, (i) {
      return Score(
        id: maps[i]['id'],
        pseudo: maps[i]['pseudo'],
        numLevel: maps[i]['level'],
        score: maps[i]['essai'],
      );
    });
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    await db.delete('pendu');
  }
}
