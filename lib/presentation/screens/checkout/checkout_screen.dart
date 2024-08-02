import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_state.dart';
import 'package:fastfood_app/logic/blocs/order/order_bloc.dart';
import 'package:fastfood_app/logic/blocs/order/order_event.dart';
import 'package:fastfood_app/logic/blocs/order/order_state.dart'; // Ensure this import
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/data/models/order_model.dart' as custom_order;
import 'package:fastfood_app/presentation/screens/checkout/confirmation_screen.dart';
import 'package:fastfood_app/presentation/widgets/order_note_widget.dart';
import 'package:fastfood_app/presentation/widgets/order_summary_widget.dart';
import 'package:fastfood_app/presentation/widgets/payment_methods_widget.dart';
import 'package:fastfood_app/presentation/widgets/user_address_widget.dart';
import 'package:fastfood_app/services/payment_service.dart';
import 'package:fastfood_app/services/stripe_service.dart';
import 'package:fastfood_app/services/paypal_service.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PaymentService paymentService = PaymentService();
  String _selectedPaymentMethod = 'Cash on Delivery';
  final TextEditingController noteController = TextEditingController();

  void _onPaymentMethodSelected(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  void _handlePlaceOrder() async {
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      final double deliveryFee = 5.0; // Assuming a flat delivery fee
      final double taxes = cartState.cart.totalPrice * 0.1; // Assuming 10% tax
      final double totalPrice = cartState.cart.totalPrice + deliveryFee + taxes;

      final order = custom_order.Order(
        id: firestore.FirebaseFirestore.instance.collection('orders').doc().id,
        userId: FirebaseAuth.instance.currentUser!.uid,
        orderItems: cartState.cart.items.map((item) => item.toMap()).toList(),
        totalPrice: totalPrice,
        status: 'processing',
        createdAt: firestore.Timestamp.now(),
        estimatedDeliveryTime: firestore.Timestamp.fromDate(
          DateTime.now().add(Duration(hours: 1)),
        ),
        paymentMethod: _selectedPaymentMethod,
        deliveryAddress: 'User delivery address', // You should fetch the actual delivery address
        note: noteController.text, // Adding the note to the order
      );

      context.read<OrderBloc>().add(CreateOrderEvent(order: order));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Color(0xFF1C2029),
      ),
      backgroundColor: Color(0xFF1C2029),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            context.read<CartBloc>().add(ClearCart());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmationScreen(order: state.order),
              ),
            );
          } else if (state is OrderError) { // Use OrderError here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Order failed: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAddressWidget(),
                SizedBox(height: 20),
                OrderSummaryWidget(),
                SizedBox(height: 20),
                OrderNoteWidget(noteController: noteController),
                SizedBox(height: 20),
                PaymentMethodsWidget(
                  onPaymentMethodSelected: _onPaymentMethodSelected,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handlePlaceOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Place Order',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
