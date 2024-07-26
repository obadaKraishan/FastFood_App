import 'package:fastfood_app/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    Center(child: Text('Orders', style: TextStyle(color: Colors.white))),
    Center(child: Text('Cart', style: TextStyle(color: Colors.white))),
    Center(child: Text('Settings', style: TextStyle(color: Colors.white))),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2029), // Dark background color
      body: _screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        backgroundColor: Color(0xFF2A313F), // Bottom bar color
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey, // Light gray color for inactive icon
            activeIcon: Icon(Icons.home, color: Colors.redAccent), // White color for active icon
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.list),
            title: Text("Orders"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey, // Light gray color for inactive icon
            activeIcon: Icon(Icons.list, color: Colors.white), // White color for active icon
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey, // Light gray color for inactive icon
            activeIcon: Icon(Icons.shopping_cart, color: Colors.white), // White color for active icon
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey, // Light gray color for inactive icon
            activeIcon: Icon(Icons.settings, color: Colors.white), // White color for active icon
          ),
        ],
      ),
    );
  }
}
