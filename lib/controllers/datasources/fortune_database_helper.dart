import 'package:fortunes_app/models/fortune_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// A utility class for managing the application's SQLite database.
/// It handles creating, updating, fetching, and deleting fortunes in the database.
class DatabaseHelper {
  static const _databaseName = "FortuneDB.db"; // Name of the database file.
  static const _databaseVersion = 1; // Version of the database. Used for migrations.
  static const table = 'fortune_table'; // Name of the table storing fortunes.

  // Private constructor to ensure this class is only instantiated once (singleton).
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  
  /// Lazily initializes and returns the database instance.
  Future<Database> get database async => _database ??= await _initDatabase();

  /// Initializes the database. This includes setting the path and creating the database file
  /// if it does not already exist.
  _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final databasePath = join(directory.path, _databaseName);
    return await openDatabase(databasePath, version: _databaseVersion, onCreate: _onCreate);
  }

  /// Creates the fortune table in the database according to the schema defined.
  /// This is called the first time the database is created.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fortune TEXT NOT NULL,
        date TEXT NOT NULL,
        color INTEGER NOT NULL
      )
    ''');
  }

  /// Inserts a new fortune into the database.
  /// Returns the ID of the newly inserted fortune.
  Future<int> createFortune(FortuneModel fortune) async {
    Database db = await database;
    return await db.insert(table, fortune.toJson());
  }

  /// Fetches a single fortune from the database by its ID.
  /// Returns a `FortuneModel` if found, or `null` if not found.
  Future<FortuneModel?> getFortune(String id) async {
    Database db = await database;
    List<Map> maps = await db.query(table, columns: ['id', 'fortune', 'date', 'color'], where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return FortuneModel.fromJson(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  /// Retrieves all fortunes from the database.
  /// Returns a list of `FortuneModel` objects.
  Future<List<FortuneModel>> getAllFortunes() async {
    Database db = await database;
    List<Map> maps = await db.query(table, columns: ['id', 'fortune', 'date', 'color']);
    return maps.map((e) => FortuneModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Updates an existing fortune in the database.
  /// Returns the number of rows affected (should be 1 if the update was successful).
  Future<int> updateFortune(FortuneModel fortune) async {
    Database db = await database;
    return await db.update(table, fortune.toJson(), where: 'id = ?', whereArgs: [fortune.id]);
  }

  /// Deletes a fortune from the database by its ID.
  /// Returns the number of rows affected (should be 1 if the deletion was successful).
  Future<int> deleteFortune(String id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
