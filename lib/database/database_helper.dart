import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ulmo_restaurants/data/model/restaurant_local_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  // Init DB
  static const String _tableName = 'restaurant';
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT,
               pictureId TEXT,
               city TEXT,
               rating REAL
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertRestaurant(RestaurantLocalModel restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toMap());
  }

  Future<List<RestaurantLocalModel>> getRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => RestaurantLocalModel.fromMap(res)).toList();
  }

  Future<RestaurantLocalModel?> getRestaurantById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.map((res) => RestaurantLocalModel.fromMap(res)).first;
    } else {
      return null;
    }
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
