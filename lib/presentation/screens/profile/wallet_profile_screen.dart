import 'package:flutter/material.dart';

class WalletProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2029),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C2029),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Your Wallet', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 24, color: Colors.white70),
        ),
      ),
    );
  }
}
