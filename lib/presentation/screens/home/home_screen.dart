import 'package:flutter/material.dart';
import 'package:fastfood_app/presentation/screens/home/category_screen.dart';
import 'package:fastfood_app/presentation/screens/home/popular_screen.dart';

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
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/onboarding/delivery_person.png', height: 130),
                SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get special discount",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "The Fastest In Delivery Food",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.redAccent, backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: Text('Order Now'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                    Navigator.pushNamed(context, '/popular');
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
