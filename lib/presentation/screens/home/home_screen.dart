import 'package:flutter/material.dart';
import 'package:fastfood_app/presentation/screens/home/category_screen.dart';
import 'package:fastfood_app/presentation/screens/home/popular_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Niloy Pordan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Featured Offer Banner
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/onboarding/delivery_person.png', height: 60),
                  SizedBox(width: 10),
                  Text(
                    "The Fastest In Delivery Food",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Category options
            CategoryScreen(),
            // Popular items
            PopularScreen(),
          ],
        ),
      ),
    );
  }
}
