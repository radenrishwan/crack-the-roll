import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/data/model/short_movie.dart';
import 'package:crack_the_roll/data/service/movie_service.dart';
import 'package:crack_the_roll/widget/carousel_card.dart';
import 'package:crack_the_roll/widget/movie_card.dart';
import 'package:crack_the_roll/widget/title_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              // TODO: implement sliver app bar
              padding: kLargePadding,
              child: AppBar(
                title: const Text('Crack The Roll.'),
                titleSpacing: 0,
                actions: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: kDefaultBorderRadius,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: kLargePadding.copyWith(top: 0),
              child: TitleWidget(
                title: 'Upcoming Movies',
                icon: Icons.movie,
                iconColor: kPrimaryColor,
              ),
            ),
            FutureBuilder<List<ShortMovie>>(
              future: MovieService().getUpcoming(),
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

                final movies = snapshot.data!;

                return CarouselSlider.builder(
                  itemCount: movies.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 280,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CarouselCard(
                          movie: movies[index],
                        );
                      },
                    );
                  },
                );
              },
            ),
            Padding(
              padding: kLargePadding,
              child: TitleWidget(
                title: 'Trending Movies',
                icon: Icons.trending_up,
                iconColor: kPrimaryColor,
                trailing: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<ShortMovie>>(
              future: MovieService().getTrending(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }

                if (snapshot.connectionState != ConnectionState.done) {
                  return SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final result = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: kLargePadding.copyWith(top: 0, bottom: kDefaultPadding.bottom),
                    child: Row(
                      children: [
                        ...List<Widget>.generate(
                          result.length,
                          (index) {
                            return MovieCard(movie: result[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: kLargePadding,
              child: TitleWidget(
                title: 'Top Rated',
                icon: Icons.star,
                iconColor: kPrimaryColor,
                trailing: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<ShortMovie>>(
              future: MovieService().getTopRated(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }

                if (snapshot.connectionState != ConnectionState.done) {
                  return SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final result = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: kLargePadding.copyWith(top: 0, bottom: kDefaultPadding.bottom),
                    child: Row(
                      children: [
                        ...List<Widget>.generate(
                          result.length,
                          (index) {
                            return MovieCard(movie: result[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
