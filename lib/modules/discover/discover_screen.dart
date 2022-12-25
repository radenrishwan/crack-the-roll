import 'dart:developer';

import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/data/model/short_movie.dart';
import 'package:crack_the_roll/data/service/movie_service.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: kLargePadding,
          child: Text('Discover'),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<ShortMovie>>(
              future: MovieService().getDiscover(1), // TODO: make it like unlimited list view
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

                final movies = snapshot.data ?? [];

                return Padding(
                  padding: kSmallPadding,
                  child: GridView.builder(
                    itemCount: movies.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: kDefaultBorderRadius,
                        ),
                        child: FancyShimmerImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w200/${movies[index].posterPath}',
                          boxFit: BoxFit.cover,
                          shimmerBaseColor: kPrimaryColor,
                          shimmerHighlightColor: kSecondaryColor,
                          shimmerBackColor: kLightBackgroundColor,
                        ),
                      );
                    },
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
