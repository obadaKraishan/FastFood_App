import 'package:fastfood_app/data/models/cart_item_model.dart';

class Cart {
  final String userId;
  final List<CartItem> items;

  Cart({required this.userId, required this.items});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      userId: map['userId'],
      items: List<CartItem>.from(map['items']?.map((item) => CartItem.fromMap(item)) ?? []),
    );
  }
}
