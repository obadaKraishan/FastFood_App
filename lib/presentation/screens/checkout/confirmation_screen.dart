// lib/presentation/screens/confirmation_screen.dart

import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/order_model.dart';

class ConfirmationScreen extends StatelessWidget {
  final Order order;

  ConfirmationScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
        backgroundColor: Color(0xFF1C2029),
      ),
      backgroundColor: Color(0xFF1C2029),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thank you for your order!',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Total Price: \$${order.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Estimated Delivery Time: ${order.estimatedDeliveryTime.toDate().toLocal()}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Continue Shopping'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/orders');
              },
              child: Text('View Orders'),
            ),
          ],
        ),
      ),
    );
  }
}
