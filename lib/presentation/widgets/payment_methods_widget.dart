import 'package:fastfood_app/data/models/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentMethodsWidget extends StatefulWidget {
  final Function(String) onPaymentMethodSelected;

  PaymentMethodsWidget({required this.onPaymentMethodSelected});

  @override
  _PaymentMethodsWidgetState createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  String _selectedPaymentMethod = 'Cash on Delivery';
  List<PaymentMethod> _paymentMethods = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _addStaticPaymentMethods();
    _fetchUserPaymentMethods();
  }

  Future<void> _fetchUserPaymentMethods() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('payment_methods')
          .get();

      setState(() {
        _paymentMethods.addAll(snapshot.docs.map((doc) => PaymentMethod.fromMap(doc.data())).toList());
        _selectedPaymentMethod = _paymentMethods.isNotEmpty ? _paymentMethods.first.id : '';
        widget.onPaymentMethodSelected(_selectedPaymentMethod);
      });
    }
  }

  void _addStaticPaymentMethods() {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;

    setState(() {
      _paymentMethods = [
        PaymentMethod(id: 'COD', name: 'Cash on Delivery', details: '', type: 'Cash'),
        PaymentMethod(id: 'PayPal', name: 'PayPal', details: '', type: 'PayPal'),
        if (isAndroid) PaymentMethod(id: 'GooglePay', name: 'Google Pay', details: '', type: 'GooglePay'),
        if (isIOS) PaymentMethod(id: 'ApplePay', name: 'Apple Pay', details: '', type: 'ApplePay'),
        PaymentMethod(id: 'Card', name: 'Debit/Credit Card', details: '', type: 'Card'),
      ];
    });
  }

  void _handlePaymentMethodSelection(String methodId) {
    setState(() {
      _selectedPaymentMethod = methodId;
    });
    widget.onPaymentMethodSelected(methodId);
  }

  IconData _getPaymentMethodIcon(String type) {
    switch (type) {
      case 'Card':
        return Icons.credit_card;
      case 'PayPal':
        return Icons.paypal_outlined;
      case 'GooglePay':
        return Icons.account_balance_wallet;
      case 'ApplePay':
        return Icons.apple;
      case 'Cash':
        return Icons.attach_money;
      default:
        return Icons.payment;
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
          leading: Icon(_getPaymentMethodIcon(method.type), color: Colors.white),
          title: Text(method.name, style: TextStyle(color: Colors.white)),
          trailing: Radio(
            value: method.id,
            groupValue: _selectedPaymentMethod,
            onChanged: (String? value) {
              if (value != null) {
                _handlePaymentMethodSelection(value);
              }
            },
            activeColor: Colors.redAccent,
          ),
        )).toList(),
      ],
    );
  }
}
