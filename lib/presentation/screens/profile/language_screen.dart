import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              // Handle change to English
            },
          ),
          ListTile(
            title: Text('Spanish'),
            onTap: () {
              // Handle change to Spanish
            },
          ),
          ListTile(
            title: Text('French'),
            onTap: () {
              // Handle change to French
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF1C2029),
    );
  }
}
