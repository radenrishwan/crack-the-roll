class Bookmark {
  static const String tableName = 'bookmarks';

  final String movieId;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String voteAverage;

  Bookmark({
    required this.movieId,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        movieId: json["movieId"],
        title: json["title"],
        posterPath: json["posterPath"],
        releaseDate: json["releaseDate"],
        voteAverage: json["voteAverage"],
      );

  Map<String, Object> toJson() => {
        "movieId": movieId,
        "title": title,
        "posterPath": posterPath,
        "releaseDate": releaseDate,
        "voteAverage": voteAverage,
      };
}
