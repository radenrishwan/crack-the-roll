import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/common/route.dart';
import 'package:crack_the_roll/modules/bookmark/bookmark_provider.dart';
import 'package:crack_the_roll/modules/discover/discorver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DiscoverProvider>(
          create: (context) => DiscoverProvider(),
        ),
        ChangeNotifierProvider<BookmarkProvider>(
          create: (context) => BookmarkProvider(),
        )
      ],
      child: const InitialApp(),
    ),
  );
}

class InitialApp extends StatelessWidget {
  const InitialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: IRouteConfig.router,
      title: 'Crack The Roll',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kLightBackgroundColor,
        indicatorColor: kPrimaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: kPrimaryColor,
          titleTextStyle: kTitleFontFamily.copyWith(
            fontWeight: FontWeight.w500,
            color: kPrimaryColor,
            letterSpacing: 1.2,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
          ),
          actionsIconTheme: const IconThemeData(
            size: 26,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kPrimaryColor,
          elevation: 2,
          selectedIconTheme: IconThemeData(
            color: kPrimaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: kSecondaryColor,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kDarkBackgroundColor,
        indicatorColor: kPrimaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: kPrimaryColor,
          titleTextStyle: kTitleFontFamily.copyWith(
            fontWeight: FontWeight.w500,
            color: kPrimaryColor,
            letterSpacing: 1.2,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
          ),
          actionsIconTheme: const IconThemeData(
            size: 26,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kPrimaryColor,
          elevation: 2,
          selectedIconTheme: IconThemeData(
            color: kPrimaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: kSecondaryColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
