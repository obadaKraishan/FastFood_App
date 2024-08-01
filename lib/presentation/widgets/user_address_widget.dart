import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        var userDocument = snapshot.data;
        String address = userDocument!['location']['address'] ?? '';
        String phoneNumber = userDocument['phone'] ?? '';

        return address.isNotEmpty && phoneNumber.isNotEmpty
            ? ListTile(
          leading: Icon(Icons.location_on, color: Colors.redAccent),
          title: Text('Delivery to: $address', style: TextStyle(color: Colors.white)),
          subtitle: Text('Phone: $phoneNumber', style: TextStyle(color: Colors.white70)),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // Navigate to address update screen
            },
          ),
        )
            : ListTile(
          leading: Icon(Icons.location_on, color: Colors.redAccent),
          title: Text('Add your delivery address', style: TextStyle(color: Colors.white)),
          trailing: IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Navigate to address add screen
            },
          ),
        );
      },
    );
  }
}
