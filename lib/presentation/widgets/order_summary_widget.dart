import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_state.dart';
import 'package:fastfood_app/presentation/widgets/cart_item.dart';

class OrderSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final cart = state.cart;
          final double subtotal = cart.items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
          final double deliveryFee = 5.0; // Assuming a flat delivery fee
          final double taxes = subtotal * 0.1; // Assuming 10% tax
          final double total = subtotal + deliveryFee + taxes;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Order', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ...cart.items.map((item) => CartItemWidget(cartItem: item, onRemove: () {}, onQuantityChanged: (quantity) {})).toList(),
              SizedBox(height: 10),
              Divider(color: Colors.white70),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: TextStyle(color: Colors.white)),
                    Text('\$${subtotal.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Fee', style: TextStyle(color: Colors.white)),
                    Text('\$${deliveryFee.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Taxes', style: TextStyle(color: Colors.white)),
                    Text('\$${taxes.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Divider(color: Colors.white70),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
