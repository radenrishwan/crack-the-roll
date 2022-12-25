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
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              size: 28,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
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

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Stack(
                    children: [
                      FancyShimmerImage(
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: 'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                        boxFit: BoxFit.cover,
                        shimmerBaseColor: kPrimaryColor,
                        shimmerHighlightColor: kSecondaryColor,
                        shimmerBackColor: kLightBackgroundColor,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: kLargePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: [
                                    Text(
                                      movie.title,
                                      style: Theme.of(context).textTheme.headline5!.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(width: kDefaultPadding.left),
                                    Text(
                                      '(${movie.originalTitle})',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: kSmallPadding.top),
                              Text(
                                movie.tagline,
                                style: Theme.of(context).textTheme.bodyText2!,
                              ),
                              SizedBox(height: kDefaultPadding.top),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: kDefaultPadding,
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: kDefaultBorderRadius,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'RATING: ${movie.voteAverage}',
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: kDefaultPadding.left),
                                  const Text('|'),
                                  SizedBox(width: kDefaultPadding.left),
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                  ),
                                  Text(
                                    '${movie.releaseDate.day}/${movie.releaseDate.month}/${movie.releaseDate.year}',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  SizedBox(width: kDefaultPadding.left),
                                  const Icon(Icons.access_alarm),
                                  Text(
                                    '${movie.runtime} min',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: kDefaultPadding.top),
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    movie.genres.length,
                                    (index) {
                                      return Container(
                                        margin: EdgeInsets.only(right: kDefaultPadding.left),
                                        padding: kDefaultPadding,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: kDefaultBorderRadius,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              movie.genres[index].name,
                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: kLargePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Text(
                        movie.overview,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Text(
                        'Information',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Text(
                        'Production',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            movie.productionCompanies.length,
                            (index) {
                              return Container(
                                margin: EdgeInsets.only(right: kDefaultPadding.left),
                                padding: kDefaultPadding,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: kDefaultBorderRadius,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      movie.productionCompanies[index].name,
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Text(
                        'Spoken Languages',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            movie.spokenLanguages.length,
                            (index) {
                              return Container(
                                margin: EdgeInsets.only(right: kDefaultPadding.left),
                                padding: kDefaultPadding,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: kDefaultBorderRadius,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      movie.spokenLanguages[index].name,
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Text(
                        'More Info',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      SizedBox(height: kDefaultPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Budget ',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '\$${movie.budget}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Revenue',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '\$${movie.revenue}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            movie.status,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Language ',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            movie.originalLanguage,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popularity',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            movie.popularity.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vote Average',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            movie.voteAverage.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vote Count ',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            movie.voteCount.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
