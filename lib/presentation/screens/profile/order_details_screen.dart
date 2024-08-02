import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: TextStyle(color: Colors.white, fontSize: 16)),
            Text('Total Price: \$${order.totalPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 16)),
            Text('Estimated Delivery Time: ${order.estimatedDeliveryTime.toDate().toLocal()}', style: TextStyle(color: Colors.white, fontSize: 16)),
            Text('Status: ${order.status}', style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 20),
            Text('Items:', style: TextStyle(color: Colors.white, fontSize: 16)),
            ...order.orderItems.map((item) => Text('${item['name']} - \$${item['price']} x ${item['quantity']}', style: TextStyle(color: Colors.white, fontSize: 16))),
            SizedBox(height: 20),
            Text('Note:', style: TextStyle(color: Colors.white, fontSize: 16)),
            Text(order.note ?? 'No special instructions', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement Cancel Order
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Cancel Order', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement Re-order
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Re-order', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement Give Us a Call
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Give Us a Call', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
