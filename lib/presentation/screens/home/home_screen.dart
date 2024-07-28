import 'package:fastfood_app/presentation/screens/categories/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:fastfood_app/presentation/screens/home/category_screen.dart';
import 'package:fastfood_app/presentation/screens/home/popular_screen.dart';
import 'package:fastfood_app/presentation/widgets/featured_banner.dart';
import 'package:fastfood_app/presentation/widgets/user_info_widget.dart'; // Import your new widget

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2029), // Dark background color
      body: HomeContentScreen(),
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: UserInfoWidget(), // Use the new widget here
          ),
          // Featured Offer Banner
          FeaturedBanner(),
          // Category options
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
          CategoryScreen(),
          // Popular items
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
          PopularScreen(),
        ],
      ),
    );
  }
}
