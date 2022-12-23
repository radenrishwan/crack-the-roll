import 'package:carousel_slider/carousel_slider.dart';
import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/widget/carousel_card.dart';
import 'package:crack_the_roll/widget/title_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight + 50),
        child: Padding(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: kLargePadding.copyWith(top: 0),
              child: TitleWidget(
                title: 'Upcoming Movies',
                icon: Icons.movie,
                iconColor: kPrimaryColor,
              ),
            ),
            CarouselSlider.builder(
              itemCount: 5,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                height: 280,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
              itemBuilder: (context, index, realIndex) {
                return Builder(
                  builder: (BuildContext context) {
                    return const CarouselCard();
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
            ...List<Widget>.generate(
              5,
              (index) {
                return Padding(
                  padding: kLargePadding.copyWith(top: 0, bottom: kDefaultPadding.bottom),
                  child: Card(
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.red,
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
