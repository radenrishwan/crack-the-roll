import 'package:crack_the_roll/bottom_navigation.dart';
import 'package:crack_the_roll/main.dart';
import 'package:crack_the_roll/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IRouteConfig {
  static const String initial = home;
  static const String home = '/home';
  static const String bookmark = '/bookmark';
  static const String detail = '/detail/:id';
  static const String search = '/search/:query';

  static const String settings = '/settings';
  static const String about = '/about';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: initial,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BottomNavigation(
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: home,
            builder: (context, state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: bookmark,
            builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: const Text('Bookmark'),
              ),
            ),
          ),
          GoRoute(
            path: settings,
            builder: (context, state) => const Scaffold(),
          ),
        ],
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
        path: about,
        builder: (context, state) => const InitialApp(),
      ),
    ],
  );
}
