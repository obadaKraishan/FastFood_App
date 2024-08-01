import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_bloc.dart';
import 'package:fastfood_app/logic/blocs/cart/cart_event.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/data/models/product_model.dart';

void addToCart(BuildContext context, ProductModel product, Function incrementCartItemCount, List<String> selectedAddons, List<String> selectedDrinks) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print('No user logged in');
    return;
  }

  // Check for null values in product fields
  if (product.id == null || product.name == null || product.price == null || product.imageUrl == null) {
    print('Product fields cannot be null');
    return;
  }

  final cartItem = CartItem(
    id: product.id,
    productId: product.id,
    name: product.name,
    price: product.price,
    quantity: 1,
    imageUrl: product.imageUrl,
    addons: selectedAddons,
    drinks: selectedDrinks,
  );

  print('Adding item to cart for user: ${user.uid}');
  print('CartItem: ${cartItem.toMap()}');

  context.read<CartBloc>().add(AddToCart(item: cartItem));
  incrementCartItemCount();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Item Added to Cart"),
        content: Text("${product.name} has been added to your cart."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Continue Shopping"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cart');
            },
            child: Text("Go to Cart"),
          ),
        ],
      );
    },
  );
}
