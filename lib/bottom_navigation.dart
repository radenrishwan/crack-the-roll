import 'package:crack_the_roll/common/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;
  const BottomNavigation({
    super.key,
    required this.child,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final tab = [
    BottomNavigationItem(
      icon: const Icon(Icons.home),
      initialLocation: IRouteConfig.home,
    ),
    BottomNavigationItem(
      icon: const Icon(Icons.bookmark),
      initialLocation: IRouteConfig.bookmark,
    ),
    BottomNavigationItem(
      icon: const Icon(Icons.settings),
      initialLocation: IRouteConfig.settings,
    ),
  ];

  int locationToTabIndex(String location) {
    final index = tab.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = locationToTabIndex(GoRouter.of(context).location);

    void moveScreen(BuildContext context, int tabIndex) {
      if (tabIndex != selectedIndex) {
        context.go(tab[tabIndex].initialLocation);
      }
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => moveScreen(context, value),
        items: tab,
      ),
    );
  }
}

class BottomNavigationItem extends BottomNavigationBarItem {
  final String initialLocation;
  @override
  BottomNavigationItem({
    required super.icon,
    required this.initialLocation,
    super.label = '',
  });
}
