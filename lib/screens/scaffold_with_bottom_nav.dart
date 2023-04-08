import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:integriteti_zgjedhor_app/constants/colors.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: tabs,
          onTap: (index) => _onItemTapped(context, index),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: kAppBarBackground,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
          selectedFontSize: 13,
          unselectedFontSize: 11,
          elevation: 2,
          selectedIconTheme: const CupertinoIconThemeData(
            size: 26,
          ),
        ),
      ),
    );
  }
}

/// Representation of a tab item in the [ScaffoldWithBottomNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(
          icon: icon,
          label: label,
        );

  /// The initial location/path
  final String initialLocation;
}

const tabs = [
  ScaffoldWithNavBarTabItem(
    initialLocation: '/home',
    icon: Icon(CupertinoIcons.home),
    label: 'Kryefaqja',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/bashkite',
    icon: Icon(Icons.domain_sharp),
    label: 'Bashkitë',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/more',
    icon: Icon(CupertinoIcons.list_bullet),
    label: 'Më shumë',
  ),
];
