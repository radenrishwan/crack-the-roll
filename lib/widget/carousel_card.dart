import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/data/model/short_movie.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final ShortMovie movie;

  const CarouselCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: kDefaultBorderRadius,
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 280,
            decoration: const BoxDecoration(color: Colors.amber),
            child: FancyShimmerImage(
              imageUrl: 'https://image.tmdb.org/t/p/original/${movie.posterPath}',
              boxFit: BoxFit.cover,
              shimmerBaseColor: kPrimaryColor,
              shimmerHighlightColor: kSecondaryColor,
              shimmerBackColor: kLightBackgroundColor,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: kDefaultPadding,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      ),
                      SizedBox(width: kSmallPadding.right),
                      Text(
                        '${movie.releaseDate.day}/${movie.releaseDate.month}/${movie.releaseDate.year}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(width: kDefaultPadding.right),
                      Icon(
                        Icons.storm_sharp,
                        color: Colors.white,
                        size: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      ),
                      SizedBox(width: kSmallPadding.right),
                      Text(
                        movie.genreIds.toString(), // TODO: implement genre
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
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
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
