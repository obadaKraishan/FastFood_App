import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fastfood_app/presentation/screens/home/category_screen.dart';
import 'package:fastfood_app/presentation/screens/home/popular_screen.dart';
import 'package:fastfood_app/presentation/widgets/featured_banner.dart';
import 'package:fastfood_app/presentation/widgets/user_info_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int cartItemCount = 0;

  void _incrementCartItemCount() {
    setState(() {
      cartItemCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C2029),
        title: Text('Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeContent: Text(cartItemCount.toString(), style: TextStyle(color: Colors.white)),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                // Handle cart icon press
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF1C2029),
      body: HomeContentScreen(incrementCartItemCount: _incrementCartItemCount),
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  final Function incrementCartItemCount;

  HomeContentScreen({required this.incrementCartItemCount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: UserInfoWidget(),
          ),
          FeaturedBanner(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/categories');
                  },
                  child: Text('View all', style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
          CategoryScreen(incrementCartItemCount: incrementCartItemCount),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/products');
                  },
                  child: Text('View all', style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
          PopularScreen(incrementCartItemCount: incrementCartItemCount),
        ],
      ),
    );
  }
}
