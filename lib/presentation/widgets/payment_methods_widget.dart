import 'package:flutter/material.dart';

class PaymentMethodsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              child: Text('Cash', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              child: Text('Card', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              child: Text('PayPal', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              child: Text('Apple Pay', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
