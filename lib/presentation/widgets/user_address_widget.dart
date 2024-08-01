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
              showEditAddressModal(context, userDocument);
            },
          ),
        )
            : ListTile(
          leading: Icon(Icons.location_on, color: Colors.redAccent),
          title: Text('Add your delivery address', style: TextStyle(color: Colors.white)),
          trailing: IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              showEditAddressModal(context, userDocument);
            },
          ),
        );
      },
    );
  }

  void showEditAddressModal(BuildContext context, DocumentSnapshot userDocument) {
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final TextEditingController _stateController = TextEditingController();
    final TextEditingController _countryController = TextEditingController();

    _phoneController.text = userDocument['phone'] ?? '';
    _addressController.text = userDocument['location']['address'] ?? '';
    _cityController.text = userDocument['location']['city'] ?? '';
    _stateController.text = userDocument['location']['state'] ?? '';
    _countryController.text = userDocument['location']['country'] ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: _stateController,
                  decoration: InputDecoration(labelText: 'State'),
                ),
                TextField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await updateUserAddress(
                      _phoneController.text,
                      _addressController.text,
                      _cityController.text,
                      _stateController.text,
                      _countryController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> updateUserAddress(
      String phone,
      String address,
      String city,
      String state,
      String country,
      ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'phone': phone,
        'location': {
          'address': address,
          'city': city,
          'state': state,
          'country': country,
        },
      });
    }
  }
}
