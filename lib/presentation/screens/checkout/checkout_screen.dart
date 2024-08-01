import 'package:flutter/material.dart';
import 'package:fastfood_app/presentation/widgets/user_address_widget.dart';
import 'package:fastfood_app/presentation/widgets/order_summary_widget.dart';
import 'package:fastfood_app/presentation/widgets/order_note_widget.dart';
import 'package:fastfood_app/presentation/widgets/payment_methods_widget.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Color(0xFF1C2029),
      ),
      backgroundColor: Color(0xFF1C2029),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAddressWidget(),
              SizedBox(height: 20),
              OrderSummaryWidget(),
              SizedBox(height: 20),
              OrderNoteWidget(),
              SizedBox(height: 20),
              PaymentMethodsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
