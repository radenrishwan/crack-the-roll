import 'package:crack_the_roll/data/domain/bookmark.dart';
import 'package:crack_the_roll/data/repository/bookmark_repository.dart';
import 'package:flutter/material.dart';

class BookmarkProvider extends ChangeNotifier {
  List<Bookmark> bookmarks = [];

  Future<void> findAll() async {
    bookmarks = await BookmarkRepository().readAll();
    notifyListeners();
  }

  Future<void> create(Bookmark bookmark) async {
    await BookmarkRepository().create(bookmark);
    findAll();
  }

  Future<void> delete(String movieId) async {
    await BookmarkRepository().delete(movieId);
    findAll();
  }

  Future<bool> checkBookmark(String movieId) async {
    await findAll();
    return bookmarks.any((element) => element.movieId == movieId);
  }
}
