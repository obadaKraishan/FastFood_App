// lib/services/paypal_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PayPalService {
  static Future<void> payWithPayPal(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
          sandboxMode: true,
          clientId: "your-client-id",
          secretKey: "your-secret-key",
          returnURL: "https://samplesite.com/return",
          cancelURL: "https://samplesite.com/cancel",
          transactions: [
            {
              "amount": {
                "total": '10.12',
                "currency": 'USD',
                "details": {
                  "subtotal": '10.12',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "A demo product",
                    "quantity": 1,
                    "price": '10.12',
                    "currency": 'USD'
                  }
                ],
                "shipping_address": {
                  "recipient_name": "Jane Foster",
                  "line1": "Travis County",
                  "line2": "",
                  "city": "Austin",
                  "country_code": "US",
                  "postal_code": "73301",
                  "phone": "+00000000",
                  "state": "Texas"
                },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");
          },
          onError: (error) {
            print("onError: $error");
          },
          onCancel: (params) {
            print('cancelled: $params');
          },
        ),
      ),
    );
  }
}
