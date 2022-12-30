import 'dart:developer';

import 'package:crack_the_roll/bottom_navigation.dart';
import 'package:crack_the_roll/main.dart';
import 'package:crack_the_roll/modules/authentication/authentication_provider.dart';
import 'package:crack_the_roll/modules/authentication/auth_screen.dart';
import 'package:crack_the_roll/modules/authentication/register_screen.dart';
import 'package:crack_the_roll/modules/bookmark/bookmark_screen.dart';
import 'package:crack_the_roll/modules/details/details_screen.dart';
import 'package:crack_the_roll/modules/discover/discover_screen.dart';
import 'package:crack_the_roll/modules/home/home_screen.dart';
import 'package:crack_the_roll/modules/settings/settings_screen.dart';
import 'package:crack_the_roll/widget/default_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IRouteConfig {
  static final AuthenticationProvider authenticatoinProvider = AuthenticationProvider();

  static const String initial = home;
  static const String home = '/home';
  static const String bookmark = '/bookmark';
  static const String discover = '/discover';

  static const String detail = '/detail/:id';
  static const String search = '/search/:query';

  static const String login = '/login';
  static const String register = '/register';

  static const String settings = '/settings';
  static const String about = '/about';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static void showGlobalDialog(String title, String content) {
    showDialog(
      barrierDismissible: true,
      context: _rootNavigatorKey.currentContext!,
      builder: (context) {
        return DefaultAlert(title: title, content: content);
      },
    );
  }

  static final router = GoRouter(
    initialLocation: initial,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: authenticatoinProvider,
    redirect: (context, state) {
      log('redirect: ${state.location}');
      if (FirebaseAuth.instance.currentUser == null) {
        if (state.location == register) {
          return register;
        }

        return login;
      }

      log('redirect: ${state.location}');
      return state.location;
    },
    routes: <RouteBase>[
      GoRoute(
        name: 'login',
        path: login,
        builder: (context, state) {
          return AuthScreen();
        },
      ),
      GoRoute(
        name: 'register',
        path: register,
        builder: (context, state) {
          return RegisterScreen();
        },
      ),
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
            builder: (context, state) => const DiscoverScreen(),
          ),
          GoRoute(
            path: bookmark,
            builder: (context, state) => const BookmarkScreen(),
          ),
          GoRoute(
            name: 'settings',
            path: settings,
            builder: (context, state) => const SettingsScreen(),
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
            ),
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
