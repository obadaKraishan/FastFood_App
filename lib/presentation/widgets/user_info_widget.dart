import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return Text(
            'Error loading user data',
            style: TextStyle(color: Colors.white),
          );
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        return Row(
          children: [
            CircleAvatar(
              backgroundImage: userData['avatar'] != null
                  ? NetworkImage(userData['avatar'])
                  : AssetImage('assets/images/onboarding/delivery_person.png') as ImageProvider,
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
                  userData['name'] ?? 'User',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.notifications, color: Colors.white),
          ],
        );
      },
    );
  }
}
