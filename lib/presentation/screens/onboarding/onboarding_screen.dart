import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
        backgroundColor: Color(0xFF1C1C1C),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset('assets/images/onboarding/onboarding-bg.png'),
            ),
            SizedBox(height: 20),
            Text(
              "Choose Your Best Delicious Food Only!",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Don't worry we are here to give the best to save your hunger problem.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between the buttons
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 40), // Add some spacing at the bottom
          ],
        ),
      ),
      backgroundColor: Color(0xFF1C1C1C), // Dark background color
    );
  }
}
