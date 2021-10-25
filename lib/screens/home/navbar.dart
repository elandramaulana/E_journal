import 'package:e_journal/screens/home/content/bookmark.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'content/home.dart';
import 'content/profile.dart';
import 'content/bookmark.dart';
import 'content/search.dart';

class FluidNavBarDemo extends StatefulWidget {
  const FluidNavBarDemo({Key? key}) : super(key: key);

  @override
  State createState() {
    return _FluidNavBarDemoState();
  }
}

class _FluidNavBarDemoState extends State {
  Widget? _child;

  @override
  void initState() {
    _child = const BookmarkContent();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE4F5FF),
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.bookmark,
                backgroundColor: const Color(0xFF4285F4),
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.home,
                backgroundColor: const Color(0xFFEC4134),
                extras: {"label": "bookmark"}),
            FluidNavBarIcon(
                icon: Icons.search,
                backgroundColor: const Color(0xFFE8F384),
                extras: {"label": "Search"}),
            FluidNavBarIcon(
                icon: Icons.person,
                backgroundColor: const Color(0xFF34A950),
                extras: {"label": "Profile"}),
          ],
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(
              iconUnselectedForegroundColor: Colors.white),
          scaleFactor: 1.5,
          defaultIndex: 1,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const BookmarkContent();
          break;
        case 1:
          _child = const HomeContent();
          break;
        case 2:
          _child = const SearchPage();
          break;
        case 3:
          _child = const ProfilePage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
        child: _child,
      );
    });
  }
}
