import 'package:flutter/material.dart';
import 'package:fastfood_app/presentation/screens/home/category_screen.dart';
import 'package:fastfood_app/presentation/screens/home/popular_screen.dart';
import 'package:fastfood_app/presentation/widgets/featured_banner.dart';

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
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/onboarding/delivery_person.png'), // Replace with actual image URL
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    Text(
                      'Niloy Pordan',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.notifications, color: Colors.white),
              ],
            ),
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
