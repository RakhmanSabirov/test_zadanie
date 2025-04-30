import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_zadanie/data/models/character_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'characters.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE characters(id INTEGER PRIMARY KEY, name TEXT)",
      );
    });
  }

  Future<void> insertCharacter(CharacterModel character) async {
    final db = await database;
    await db.insert(
      'characters',
      character.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CharacterModel>> getAllCharacters() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('characters');

    return List.generate(maps.length, (i) {
      return CharacterModel.fromMap(maps[i]);
    });
  }
}
