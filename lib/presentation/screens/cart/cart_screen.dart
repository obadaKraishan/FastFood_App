// lib/presentation/screens/cart/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_state.dart';
import 'package:fastfood_app/presentation/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch the LoadCart event to fetch the cart items when the screen is initialized
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cart.items[index];
                      return CartItemWidget(
                        cartItem: cartItem,
                        onRemove: () {
                          context.read<CartBloc>().add(RemoveFromCart(productId: cartItem.productId));
                        },
                        onQuantityChanged: (quantity) {
                          if (quantity > 0) {
                            context.read<CartBloc>().add(UpdateCartItem(
                              item: cartItem.copyWith(quantity: quantity),
                            ));
                          }
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("\$${state.cart.items.fold<double>(0.0, (sum, item) => sum + item.price * item.quantity).toStringAsFixed(2)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to payment screen
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text('Proceed to Checkout', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
