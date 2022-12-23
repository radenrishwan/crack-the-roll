import 'package:crack_the_roll/common/constant.dart';
import 'package:crack_the_roll/common/route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const InitialApp());
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
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kDarkBackgroundColor,
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
