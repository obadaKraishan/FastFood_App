import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood_app/data/models/payment_method_model.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  @override
  _AddPaymentMethodScreenState createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String _type = 'Card';

  Future<void> _addPaymentMethod() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final newPaymentMethod = PaymentMethod(
        id: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('payment_methods').doc().id,
        name: _nameController.text,
        type: _type,
        details: _detailsController.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('payment_methods')
          .doc(newPaymentMethod.id)
          .set(newPaymentMethod.toMap());

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            DropdownButton<String>(
              value: _type,
              onChanged: (String? newValue) {
                setState(() {
                  _type = newValue!;
                });
              },
              items: <String>['Card', 'PayPal', 'Cash']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPaymentMethod,
              child: Text('Add Payment Method'),
            ),
          ],
        ),
      ),
    );
  }
}
