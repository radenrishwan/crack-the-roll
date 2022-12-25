import 'dart:developer';

import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/modules/discover/discorver_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        context.read<DiscoverProvider>().loadMoreMovies();
      }
    });
    super.initState();
  }

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
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: context.read<DiscoverProvider>().loadMoreMovies(), // TODO: make it like unlimited list view
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (snapshot.connectionState != ConnectionState.done) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Consumer<DiscoverProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: kSmallPadding,
                      child: GridView.builder(
                        itemCount: provider.movies.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 0.5,
                        ),
                        itemBuilder: (context, index) {
                          final movie = provider.movies[index];
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                'detail',
                                params: {'id': movie.id.toString()},
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: kDefaultBorderRadius,
                              ),
                              child: FancyShimmerImage(
                                imageUrl: 'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                                boxFit: BoxFit.cover,
                                shimmerBaseColor: kPrimaryColor,
                                shimmerHighlightColor: kSecondaryColor,
                                shimmerBackColor: kLightBackgroundColor,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
