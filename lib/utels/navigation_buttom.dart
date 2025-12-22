import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_task/view/home_screen.dart';

import '../view/favorite_page.dart';
import '../view/profile_page.dart';
import '../view/search_screen.dart';

class ButtomNavigationBar extends StatefulWidget {
  const ButtomNavigationBar({super.key});

  @override
  State<ButtomNavigationBar> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<ButtomNavigationBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      ProductSearchScreen(),
      FavoritesScreen(),
      ProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Home".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: "search".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: "favorite".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Profile".tr(),
          ),
        ],
      ),
    );
  }
}

