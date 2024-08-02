import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static void init() {
    Stripe.publishableKey = "your-publishable-key";
  }

  static Future<void> payWithCard({required String amount, required String currency}) async {
    try {
      // Create a payment intent on your backend and fetch the client secret
      final paymentIntentClientSecret = await _createPaymentIntent(amount, currency);

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Your Merchant Name',
        ),
      );

      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      print('Payment successful');
    } catch (e) {
      print('Payment failed: $e');
    }
  }

  static Future<String> _createPaymentIntent(String amount, String currency) async {
    // Replace with your backend call to create a payment intent
    // Example response from your backend: {"client_secret": "your-client-secret"}
    // For testing, you can use a mock response
    return 'your-client-secret';
  }
}
