import 'dart:developer';

import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/modules/bookmark/bookmark_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: FutureBuilder(
        future: context.read<BookmarkProvider>().findAll(),
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

          return Consumer<BookmarkProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: kDefaultPadding,
                child: ListView.builder(
                  itemCount: provider.bookmarks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: kDefaultPadding.copyWith(top: 0, left: 0, right: 0),
                      child: InkWell(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            'detail',
                            params: {'id': provider.bookmarks[index].movieId.toString()},
                          );
                        },
                        child: Card(
                          color: kTertiaryColor,
                          child: SizedBox(
                            height: 160,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: kDefaultBorderRadius.copyWith(
                                        topRight: Radius.zero,
                                        bottomRight: Radius.zero,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: kDefaultBorderRadius.copyWith(
                                        topRight: Radius.zero,
                                        bottomRight: Radius.zero,
                                      ),
                                      child: FancyShimmerImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w200/${provider.bookmarks[index].posterPath}',
                                        boxFit: BoxFit.cover,
                                        shimmerBaseColor: kPrimaryColor,
                                        shimmerHighlightColor: kSecondaryColor,
                                        shimmerBackColor: kLightBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: kDefaultPadding,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.bookmarks[index].title,
                                          style: Theme.of(context).textTheme.headline6,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: kDefaultPadding.top),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.calendar_month),
                                            SizedBox(width: kSmallPadding.left),
                                            Text(
                                              provider.bookmarks[index].releaseDate,
                                              style: Theme.of(context).textTheme.bodyText1,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
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
                                                    'RATING: ${provider.bookmarks[index].voteAverage}',
                                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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
    );
  }
}
