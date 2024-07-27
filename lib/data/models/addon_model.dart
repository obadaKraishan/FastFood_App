import 'package:equatable/equatable.dart';

class AddonModel extends Equatable {
  final String id;
  final String name;
  final double price;
  final String categoryId;
  final List<String> productIds; // List of product IDs that use this addon

  AddonModel({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.productIds, // Initialize the list
  });

  @override
  List<Object> get props => [id, name, price, categoryId, productIds]; // Include productIds

  factory AddonModel.fromMap(Map<String, dynamic> map) {
    return AddonModel(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      categoryId: map['categoryId'],
      productIds: List<String>.from(map['productIds']), // Parse the list of product IDs
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'categoryId': categoryId,
      'productIds': productIds, // Include productIds
    };
  }
}
