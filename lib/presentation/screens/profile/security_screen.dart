import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              // Handle change password
            },
          ),
          ListTile(
            leading: Icon(Icons.fingerprint),
            title: Text('Enable Fingerprint'),
            onTap: () {
              // Handle enable fingerprint
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Two-Factor Authentication'),
            onTap: () {
              // Handle two-factor authentication
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF1C2029),
    );
  }
}
