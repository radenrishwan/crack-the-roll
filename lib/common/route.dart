import 'package:crack_the_roll/main.dart';
import 'package:crack_the_roll/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IRouteConfig {
  static const String home = '/';
  static const String detail = '/detail/:id';
  static const String search = '/search/:query';

  static const String settings = '/settings';
  static const String about = '/about';

  static final router = GoRouter(
    initialLocation: home,
    routes: <RouteBase>[
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: detail,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const InitialApp(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: search,
        builder: (context, state) => const InitialApp(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const InitialApp(),
      ),
      GoRoute(
        path: about,
        builder: (context, state) => const InitialApp(),
      ),
    ],
  );
}
