import 'package:crack_the_roll/common/constant.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key});

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
            decoration: const BoxDecoration(color: Colors.amber),
            child: Image.network(
              'https://image.tmdb.org/t/p/original/5ScPNT6fHtfYJeWBajZciPV3hEL.jpg',
              fit: BoxFit.cover,
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
                    'Avatar : The Way of Water',
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
                        '2021-09-01',
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
                        'Action',
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
                    '8.5',
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
