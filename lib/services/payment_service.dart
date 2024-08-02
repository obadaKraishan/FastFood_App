import 'package:pay/pay.dart';
import 'package:flutter/material.dart';

class PaymentService {
  final _paymentItems = <PaymentItem>[
    PaymentItem(
      label: 'Total',
      amount: '10.00',
      status: PaymentItemStatus.final_price,
    ),
  ];

  Future<void> payWithGooglePay(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Google Pay'),
          content: Text('Complete your payment using Google Pay.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      print('Google Pay payment completed');
    }
  }

  Future<void> payWithApplePay(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Apple Pay'),
          content: Text('Complete your payment using Apple Pay.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      print('Apple Pay payment completed');
    }
  }

  Widget buildGooglePayButton(BuildContext context) {
    return FutureBuilder<PaymentConfiguration>(
      future: PaymentConfiguration.fromAsset('gpay.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return GooglePayButton(
            paymentConfiguration: snapshot.data!,
            paymentItems: _paymentItems,
            onPaymentResult: (result) {
              print('Google Pay Result: $result');
            },
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildApplePayButton(BuildContext context) {
    return FutureBuilder<PaymentConfiguration>(
      future: PaymentConfiguration.fromAsset('applepay.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ApplePayButton(
            paymentConfiguration: snapshot.data!,
            paymentItems: _paymentItems,
            onPaymentResult: (result) {
              print('Apple Pay Result: $result');
            },
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
