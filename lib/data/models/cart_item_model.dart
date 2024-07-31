import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String productId;
  final int quantity;
  final double price;
  final String name;
  final String imageUrl; // Add this field if you need image URL

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'],
      name: map['name'],
      imageUrl: map['imageUrl'], // Add this field if you need image URL
    );
  }

  CartItem copyWith({
    String? id,
    String? productId,
    int? quantity,
    double? price,
    String? name,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
