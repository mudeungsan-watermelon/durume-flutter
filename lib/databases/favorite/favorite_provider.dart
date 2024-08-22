import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorite.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorite(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            x TEXT,
            y TEXT
          )
        ''');
      }
    );
  }

  Future<int> insertFavorite(Favorite favorite) async {
    Database db = await database;
    return await db.insert('favorite', favorite.toMap());
  }

  Future<List<Favorite>> getFavorite() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('favorite');
    return List.generate(maps.length, (i) {
      return Favorite(
        id: maps[i]['id'],
        name: maps[i]['name'],
        position: LatLng(double.parse(maps[i]['y']), double.parse(maps[i]['x']))
      );
    });
  }

  Future<void> updateFavorite(Favorite favorite) async {
    Database db = await database;
    await db.update(
      'favorite',
      favorite.toMap(),
      where: 'id = ?',
      whereArgs: [favorite.id],
    );
  }

  Future<void> deleteFavorite(int id) async {
    Database db = await database;
    await db.delete(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}