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

  void onGooglePayResult(paymentResult) {
    // Handle the payment result
    print('Google Pay Result: $paymentResult');
  }

  void onApplePayResult(paymentResult) {
    // Handle the payment result
    print('Apple Pay Result: $paymentResult');
  }

  Widget buildGooglePayButton(BuildContext context) {
    return FutureBuilder<PaymentConfiguration>(
      future: PaymentConfiguration.fromAsset('gpay.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return GooglePayButton(
            paymentConfiguration: snapshot.data!,
            paymentItems: _paymentItems,
            onPaymentResult: onGooglePayResult,
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
            onPaymentResult: onApplePayResult,
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
