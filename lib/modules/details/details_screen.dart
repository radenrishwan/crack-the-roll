import 'dart:developer';

import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/data/model/movie.dart';
import 'package:crack_the_roll/data/service/movie_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int movieId;
  const DetailScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Movie>(
        future: MovieService().getMovie(movieId.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 280,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final movie = snapshot.data!;

          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.45,
                  floating: false,
                  pinned: true,
                  titleSpacing: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      movie.title,
                    ),
                    background: FancyShimmerImage(
                      imageUrl: 'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                      boxFit: BoxFit.cover,
                      shimmerBaseColor: kPrimaryColor,
                      shimmerHighlightColor: kSecondaryColor,
                      shimmerBackColor: kLightBackgroundColor,
                    ),
                  ),
                ),
              ];
            },
            body: const Center(
              child: Text("Sample text"),
            ),
          );
        },
      ),
    );
  }
}
