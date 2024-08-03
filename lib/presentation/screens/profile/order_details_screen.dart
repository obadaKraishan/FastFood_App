import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/data/models/order_model.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/logic/blocs/order/order_bloc.dart';
import 'package:fastfood_app/logic/blocs/order/order_event.dart';
import 'package:fastfood_app/logic/blocs/order/order_state.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  OrderDetailsScreen({required this.orderId, Key? key}) : super(key: key);

  void _showCancelOrderConfirmation(BuildContext context, model.Order order) {
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
                BlocProvider.of<OrderBloc>(context).add(UpdateOrderStatusEvent(
                  orderId: order.id,
                  status: 'canceled',
                  userId: order.userId,
                ));
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showReorderConfirmation(BuildContext context, model.Order order) {
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
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Center(child: Text('User not logged in'));
    }
    final userId = user.uid;

    BlocProvider.of<OrderBloc>(context).add(LoadOrdersEvent(userId: userId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            final updatedOrder = state.orders.firstWhere(
                  (o) => o.id == orderId,
              orElse: () => model.Order(
                id: '',
                userId: '',
                orderItems: [],
                totalPrice: 0.0,
                status: '',
                createdAt: Timestamp.now(),
                estimatedDeliveryTime: Timestamp.now(),
                paymentMethod: '',
                deliveryAddress: '',
              ),
            );
            if (updatedOrder.id.isEmpty) {
              return Center(child: Text('Order not found'));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${updatedOrder.id}', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('Total Price: \$${updatedOrder.totalPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('Estimated Delivery Time: ${updatedOrder.estimatedDeliveryTime.toDate().toLocal()}', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('Status: ${updatedOrder.status}', style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Items:', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ...updatedOrder.orderItems.map((item) {
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
                  Text(updatedOrder.note ?? 'No special instructions', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showCancelOrderConfirmation(context, updatedOrder),
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
                          onPressed: () => _showReorderConfirmation(context, updatedOrder),
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
            );
          } else if (state is OrderError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
