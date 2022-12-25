import 'package:crack_the_roll/bottom_navigation.dart';
import 'package:crack_the_roll/main.dart';
import 'package:crack_the_roll/modules/details/details_screen.dart';
import 'package:crack_the_roll/modules/discover/discover_screen.dart';
import 'package:crack_the_roll/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IRouteConfig {
  static const String initial = home;
  static const String home = '/home';
  static const String bookmark = '/bookmark';
  static const String discover = '/discover';

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
            name: 'home',
            path: home,
            builder: (context, state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            name: 'discover',
            path: discover,
            builder: (context, state) => DiscoverScreen(),
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
            name: 'settings',
            path: settings,
            builder: (context, state) => const Scaffold(),
          ),
        ],
      ),
      GoRoute(
        name: 'detail',
        path: detail,
        pageBuilder: (context, state) {
          final id = int.parse(state.params['id'] ?? '0');

          return CustomTransitionPage(
            child: DetailScreen(
              movieId: id,
            ), // TODO: change this fucking mock
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
        name: 'search',
        path: search,
        builder: (context, state) => const InitialApp(),
      ),
      GoRoute(
        name: 'about',
        path: about,
        builder: (context, state) => const InitialApp(),
      ),
    ],
  );
}
