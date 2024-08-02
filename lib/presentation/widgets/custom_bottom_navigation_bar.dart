import 'package:fastfood_app/presentation/screens/home/home_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/orders_screen.dart';
import 'package:fastfood_app/presentation/screens/profile/profile_screen.dart';
import 'package:fastfood_app/presentation/screens/cart/cart_screen.dart';
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
    OrdersScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2029),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        backgroundColor: Color(0xFF2A313F),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.list),
            title: Text("Orders"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.account_circle_outlined),
            title: Text("Profile"),
            selectedColor: Colors.redAccent,
            unselectedColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
