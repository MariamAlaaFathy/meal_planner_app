import 'package:flutter/material.dart';
import 'package:meal_planner_app/pages/calendarPage.dart';
import 'package:meal_planner_app/pages/home_page.dart';  // ← إضافة
import 'package:meal_planner_app/pages/searchPage.dart';
import 'package:meal_planner_app/screens/explore_categories_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;  

  final List<Widget> _tabs = const [
    HomePage(),  
    SearchPage(),
    ExploreCategoriesScreen(),
    Center(
      child: Text('Favorites tab', style: TextStyle(color: Colors.grey)),
    ),
    CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}