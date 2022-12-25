import 'package:crack_the_roll/config/sqlite.dart';
import 'package:crack_the_roll/data/domain/bookmark.dart';

class BookmarkRepository {
  static final BookmarkRepository _instance = BookmarkRepository._();

  factory BookmarkRepository() {
    return _instance;
  }

  BookmarkRepository._();

  Future<Bookmark> create(Bookmark bookmark) async {
    final database = await Sqlite().database;
    final int status = await database.insert(Bookmark.tableName, bookmark.toJson());

    if (status == 0) {
      throw Exception("Failed to create note");
    }

    return bookmark;
  }

  Future<List<Bookmark>> readAll() async {
    final database = await Sqlite().database;

    final List<Map<String, dynamic>> maps = await database.query(Bookmark.tableName);

    return List.generate(maps.length, (i) {
      return Bookmark.fromJson(maps[i]);
    });
  }

  Future<void> delete(String movieId) async {
    final database = await Sqlite().database;

    await database.delete(Bookmark.tableName, where: 'movieId = ?', whereArgs: [movieId]);
  }
}
