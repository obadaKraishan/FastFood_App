import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_state.dart';
import 'package:fastfood_app/presentation/widgets/cart_item.dart';

class OrderSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No items to checkout', style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text('Go to Home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final cart = state.cart;
          final double subtotal = cart.items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
          final double deliveryFee = 5.0; // Assuming a flat delivery fee
          final double taxes = subtotal * 0.1; // Assuming 10% tax
          final double total = subtotal + deliveryFee + taxes;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Order', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ...cart.items.map((item) => CartItemWidget(
                cartItem: item,
                onRemove: () {
                  context.read<CartBloc>().add(RemoveFromCart(productId: item.productId));
                },
                onQuantityChanged: (quantity) {
                  if (quantity > 0) {
                    context.read<CartBloc>().add(UpdateCartItem(
                      item: item.copyWith(quantity: quantity),
                    ));
                  }
                },
              )).toList(),
              SizedBox(height: 10),
              Divider(color: Colors.white70),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
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
        } else if (state is CartLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CartError) {
          return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
        } else {
          return Container();
        }
      },
    );
  }
}
