// lib/data/models/cart_model.dart

import 'package:fastfood_app/data/models/cart_item_model.dart';

class Cart {
  final String userId;
  final List<CartItem> items;
  final double tax;
  final double deliveryFee;

  Cart({
    required this.userId,
    required this.items,
    this.tax = 0.0,
    this.deliveryFee = 0.0,
  });

  double get subTotal {
    return items.fold(0, (total, item) => total + item.price * item.quantity);
  }

  double get totalPrice {
    return subTotal + tax + deliveryFee;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'tax': tax,
      'deliveryFee': deliveryFee,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      userId: map['userId'],
      items: List<CartItem>.from(map['items']?.map((item) => CartItem.fromMap(item)) ?? []),
      tax: map['tax'] ?? 0.0,
      deliveryFee: map['deliveryFee'] ?? 0.0,
    );
  }
}
