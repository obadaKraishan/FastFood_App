import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Push Notifications'),
            value: true,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text('Email Notifications'),
            value: false,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text('SMS Notifications'),
            value: true,
            onChanged: (bool value) {},
          ),
        ],
      ),
      backgroundColor: Color(0xFF1C2029),
    );
  }
}
