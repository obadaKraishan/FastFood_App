import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String productId;
  final int quantity;
  final double price;
  final String name;
  final String imageUrl;
  final List<String> addons;
  final List<String> drinks;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.imageUrl,
    required this.addons,
    required this.drinks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'name': name,
      'imageUrl': imageUrl,
      'addons': addons,
      'drinks': drinks,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      addons: List<String>.from(map['addons']),
      drinks: List<String>.from(map['drinks']),
    );
  }

  CartItem copyWith({
    String? id,
    String? productId,
    int? quantity,
    double? price,
    String? name,
    String? imageUrl,
    List<String>? addons,
    List<String>? drinks,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      addons: addons ?? this.addons,
      drinks: drinks ?? this.drinks,
    );
  }
}
