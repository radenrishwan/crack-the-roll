import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/data/model/short_movie.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final ShortMovie movie;
  bool showRating = true;
  final VoidCallback onTap;
  MovieCard({super.key, required this.movie, this.showRating = true, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: kDefaultPadding.copyWith(top: 0, bottom: 0, left: 0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: kDefaultBorderRadius,
              ),
              child: ClipRRect(
                borderRadius: kDefaultBorderRadius,
                child: FancyShimmerImage(
                  width: 170,
                  imageUrl: 'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                  boxFit: BoxFit.cover,
                  shimmerBaseColor: kPrimaryColor,
                  shimmerHighlightColor: kSecondaryColor,
                  shimmerBackColor: kLightBackgroundColor,
                ),
              ),
            ),
            showRating
                ? Positioned(
                    top: 50,
                    right: 0,
                    child: Container(
                      padding: kSmallPadding,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: kDefaultBorderRadius.copyWith(
                            topRight: const Radius.circular(0),
                            bottomRight: const Radius.circular(0),
                          )),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: kPrimaryColor,
                            size: Theme.of(context).textTheme.headline5!.fontSize,
                          ),
                          SizedBox(width: kSmallPadding.right),
                          Text(
                            '8.5',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
