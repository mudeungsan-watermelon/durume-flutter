import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SearchHistoryProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'search_history.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE search_history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            query TEXT
          )
        ''');
        }
    );
  }

  Future<int> insertSearchHistory(SearchHistory searchHistory) async {
    Database db = await database;
    return await db.insert('search_history', searchHistory.toMap());
  }

  Future<List<SearchHistory>> getSearchHistory() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('search_history');
    return List.generate(maps.length, (i) {
      return SearchHistory(
        id: maps[i]['id'],
        query: maps[i]['query'],
      );
    });
  }

  Future<void> updateSearchHistory(SearchHistory searchHistory) async {
    Database db = await database;
    await db.update(
      'search_history',
      searchHistory.toMap(),
      where: 'id = ?',
      whereArgs: [searchHistory.id],
    );
  }

  Future<void> deleteSearchHistory(int id) async {
    Database db = await database;
    await db.delete(
      'search_history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllSearchHistory() async {
    Database db = await database;
    await db.delete('search_history');
  }
}