import 'package:fastfood_app/presentation/widgets/order_note_widget.dart';
import 'package:fastfood_app/presentation/widgets/order_summary_widget.dart';
import 'package:fastfood_app/presentation/widgets/payment_methods_widget.dart';
import 'package:fastfood_app/presentation/widgets/user_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_state.dart';
import 'package:fastfood_app/services/payment_service.dart';
import 'package:fastfood_app/services/stripe_service.dart';
import 'package:fastfood_app/services/paypal_service.dart';

class CheckoutScreen extends StatelessWidget {
  final PaymentService paymentService = PaymentService();

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
              SizedBox(height: 20),
              paymentService.buildGooglePayButton(context),
              SizedBox(height: 10),
              paymentService.buildApplePayButton(context),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await StripeService.payWithCard(amount: '10.00', currency: 'USD'); // Example amount and currency
                },
                child: Text('Pay with Card'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await PayPalService.payWithPayPal(context);
                },
                child: Text('Pay with PayPal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
