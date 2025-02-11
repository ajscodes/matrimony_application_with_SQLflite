import 'package:flutter/material.dart';
import 'package:matrimony_application/screens/list_page.dart';
import 'home_screen.dart';
import 'bookmark_screen.dart';
import 'aboutus_screen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ListPage(),
    BookmarkScreen(),
    AboutusScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'User List'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About Us'),
        ],
      ),
    );
  }
}
