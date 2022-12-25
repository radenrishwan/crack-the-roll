import 'package:crack_the_roll/data/domain/bookmark.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite {
  static final Sqlite _instance = Sqlite._();
  static Database? _database;

  factory Sqlite() {
    return _instance;
  }

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Sqlite._();

  Future<Database> _initDB() async {
    return await openDatabase(
      'database.db',
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) async {},
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE  IF NOT EXISTS ${Bookmark.tableName} (
            movieId TEXT PRIMARY KEY,
            title TEXT,
            posterPath TEXT,
            releaseDate TEXT,
            voteAverage TEXT
          )
          ''');
      },
    );
  }
}
