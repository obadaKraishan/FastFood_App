// lib/presentation/widgets/payment_methods_widget.dart

import 'package:fastfood_app/data/models/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentMethodsWidget extends StatefulWidget {
  @override
  _PaymentMethodsWidgetState createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  String _selectedPaymentMethod = '';
  List<PaymentMethod> _paymentMethods = [];

  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
  }

  Future<void> _fetchPaymentMethods() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('payment_methods')
          .get();

      setState(() {
        _paymentMethods = snapshot.docs.map((doc) => PaymentMethod.fromMap(doc.data())).toList();
        _selectedPaymentMethod = _paymentMethods.isNotEmpty ? _paymentMethods.first.id : '';
      });
    }
  }

  Future<void> _updateSelectedPaymentMethod(String methodId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'selectedPaymentMethod': methodId,
      });
      setState(() {
        _selectedPaymentMethod = methodId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        ..._paymentMethods.map((method) => ListTile(
          leading: method.type == 'Card'
              ? Icon(Icons.credit_card, color: Colors.white)
              : method.type == 'PayPal'
              ? Icon(Icons.account_balance_wallet, color: Colors.white)
              : Icon(Icons.attach_money, color: Colors.white),
          title: Text(method.name, style: TextStyle(color: Colors.white)),
          subtitle: Text(method.details, style: TextStyle(color: Colors.white70)),
          trailing: Radio(
            value: method.id,
            groupValue: _selectedPaymentMethod,
            onChanged: (String? value) {
              _updateSelectedPaymentMethod(value!);
            },
            activeColor: Colors.redAccent,
          ),
        )).toList(),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add-payment-method');
          },
          child: Text('Add Payment Method'),
        ),
      ],
    );
  }
}
