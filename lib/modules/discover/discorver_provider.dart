import 'package:crack_the_roll/data/model/short_movie.dart';
import 'package:crack_the_roll/data/service/movie_service.dart';
import 'package:flutter/cupertino.dart';

class DiscoverProvider extends ChangeNotifier {
  List<ShortMovie> movies = [];
  int page = 1;
  final MovieService _movieService = MovieService();

  Future<void> loadMoreMovies() async {
    final List<ShortMovie> newMovies = await _movieService.getDiscover(page);
    movies.addAll(newMovies);

    if (movies.isEmpty) {
      page = 1;
    } else {
      page++;
    }

    notifyListeners();
  }
}
