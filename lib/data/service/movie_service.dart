import 'dart:convert';

import 'package:crack_the_roll/data/model/movie.dart';
import 'package:crack_the_roll/data/model/short_movie.dart';
import 'package:http/http.dart' as http;

class MovieService {
  final String _apiKey = '40be8d96983b438acea76017aedaca81';
  final String _endpoint = 'https://api.themoviedb.org/3';
  static final MovieService _instance = MovieService._();

  factory MovieService() {
    return _instance;
  }

  MovieService._();

  Future<Movie> getMovie(String id) async {
    final response = await http.get(
      Uri.parse(
        '$_endpoint/movie/$id?api_key=$_apiKey',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Movie.fromJson(json);
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<List<ShortMovie>> getUpcoming() async {
    final List<ShortMovie> result = [];
    final response = await http.get(
      Uri.parse('$_endpoint/movie/upcoming?api_key=$_apiKey&language=en-US&page=1'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['results'] != null) {
        for (final item in json['results']) {
          result.add(ShortMovie.fromJson(item));
        }
      }
    }

    return result;
  }

  Future<List<ShortMovie>> getTrending() async {
    final List<ShortMovie> result = [];
    final response = await http.get(
      Uri.parse('$_endpoint/movie/popular?api_key=$_apiKey&language=en-US&page=1'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['results'] != null) {
        for (final item in json['results']) {
          result.add(ShortMovie.fromJson(item));
        }
      }
    }

    return result;
  }

  Future<List<ShortMovie>> getTopRated() async {
    final List<ShortMovie> result = [];
    final response = await http.get(
      Uri.parse('$_endpoint/movie/top_rated?api_key=$_apiKey&language=en-US&page=1'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['results'] != null) {
        for (final item in json['results']) {
          result.add(ShortMovie.fromJson(item));
        }
      }
    }

    return result;
  }

  Future<List<ShortMovie>> getDiscover(int page) async {
    final List<ShortMovie> result = [];
    final response = await http.get(
      Uri.parse(
          '$_endpoint/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_watch_monetization_types=flatrate'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['results'] != null) {
        for (final item in json['results']) {
          result.add(ShortMovie.fromJson(item));
        }
      }
    }

    return result;
  }
}
