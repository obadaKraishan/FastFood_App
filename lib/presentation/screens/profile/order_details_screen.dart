import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/order_model.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/data/repositories/order_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({required this.order});

  void _showCancelOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Order'),
          content: Text('Are you sure you want to cancel this order?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _cancelOrder(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _cancelOrder(BuildContext context) {
    final orderRepository = RepositoryProvider.of<OrderRepository>(context);
    orderRepository.updateOrderStatus(order.id, 'canceled');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order canceled')),
    );
  }

  void _showReorderConfirmation(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(ClearCart());

    for (var item in order.orderItems) {
      cartBloc.add(AddToCart(item: CartItem.fromMap(item)));
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Re-order'),
          content: Text('Items have been added to your cart. Go to cart or continue adding more items?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/cart');
              },
              child: Text('Go to Cart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/categories');
              },
              child: Text('Continue Adding'),
            ),
          ],
        );
      },
    );
  }

  void _makeCall() async {
    const phoneNumber = 'tel:+1234567890';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

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
            ...order.orderItems.map((item) {
              // Ensure addons and drinks are handled as lists
              List<dynamic> addons = item['addons'] is List ? item['addons'] : [];
              List<dynamic> drinks = item['drinks'] is List ? item['drinks'] : [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item['name']} - \$${item['price']} x ${item['quantity']}', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ...addons.map((addon) {
                    if (addon is Map<String, dynamic>) {
                      return Text('Addon: ${addon['name']} - \$${addon['price']}', style: TextStyle(color: Colors.white70, fontSize: 14));
                    } else {
                      return Container();
                    }
                  }).toList(),
                  ...drinks.map((drink) {
                    if (drink is Map<String, dynamic>) {
                      return Text('Drink: ${drink['name']} - \$${drink['price']}', style: TextStyle(color: Colors.white70, fontSize: 14));
                    } else {
                      return Container();
                    }
                  }).toList(),
                ],
              );
            }).toList(),
            SizedBox(height: 20),
            Text('Note:', style: TextStyle(color: Colors.white, fontSize: 16)),
            Text(order.note ?? 'No special instructions', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showCancelOrderConfirmation(context),
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
                    onPressed: () => _showReorderConfirmation(context),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _makeCall,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Give Us a Call', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
