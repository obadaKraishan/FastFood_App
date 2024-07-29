import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOptionItem(
          icon: Icons.edit,
          text: 'Edit Profile',
          onTap: () {
            Navigator.pushNamed(context, '/edit_profile');
          },
        ),
        ProfileOptionItem(
          icon: Icons.notifications,
          text: 'Notification',
          onTap: () {
            Navigator.pushNamed(context, '/notifications');
          },
        ),
        ProfileOptionItem(
          icon: Icons.account_balance_wallet,
          text: 'Wallet',
          onTap: () {
            Navigator.pushNamed(context, '/wallet');
          },
        ),
        ProfileOptionItem(
          icon: Icons.security,
          text: 'Security',
          onTap: () {
            Navigator.pushNamed(context, '/security');
          },
        ),
        ProfileOptionItem(
          icon: Icons.language,
          text: 'Language',
          onTap: () {
            Navigator.pushNamed(context, '/language');
          },
        ),
      ],
    );
  }
}

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  ProfileOptionItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFF2A313F),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}
