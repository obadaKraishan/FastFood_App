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

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PaymentService paymentService = PaymentService();
  String _selectedPaymentMethod = 'Cash on Delivery';

  void _onPaymentMethodSelected(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  void _handlePlaceOrder() async {
    switch (_selectedPaymentMethod) {
      case 'COD':
      // Handle Cash on Delivery
        break;
      case 'PayPal':
        await PayPalService.payWithPayPal(context);
        break;
      case 'GooglePay':
        await paymentService.payWithGooglePay(context);
        break;
      case 'ApplePay':
        await paymentService.payWithApplePay(context);
        break;
      case 'Card':
        await StripeService.payWithCard(amount: '10.00', currency: 'USD'); // Example amount and currency
        break;
      default:
        print('Unknown payment method selected');
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
    );
  }
}
