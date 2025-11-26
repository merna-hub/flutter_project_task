import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_task/view/home_screen.dart';

import '../view/favorite_page.dart';
import '../view/profile_page.dart';

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

  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text('Search Page'.tr())),
    FavoritesScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "search".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "favoirte".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile".tr(),
          ),
        ],
      ),
    );
  }
}
