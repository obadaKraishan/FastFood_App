import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isMandatory;
  final String categoryId;
  final List<String> productIds; // List of product IDs that use this ingredient

  IngredientModel({
    required this.id,
    required this.name,
    required this.price,
    required this.isMandatory,
    required this.categoryId,
    required this.productIds, // Initialize the list
  });

  @override
  List<Object> get props => [id, name, price, isMandatory, categoryId, productIds]; // Include productIds

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      isMandatory: map['isMandatory'],
      categoryId: map['categoryId'],
      productIds: List<String>.from(map['productIds']), // Parse the list of product IDs
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isMandatory': isMandatory,
      'categoryId': categoryId,
      'productIds': productIds, // Include productIds
    };
  }
}
