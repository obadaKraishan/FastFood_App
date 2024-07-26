import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String categoryId;
  final double rating;
  final int reviews;
  final int calories;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.categoryId,
    required this.rating,
    required this.reviews,
    required this.calories,
  });

  @override
  List<Object> get props => [id, name, price, imageUrl, description, categoryId, rating, reviews, calories];

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'],
      description: map['description'],
      categoryId: map['categoryId'],
      rating: (map['rating'] as num).toDouble(), // Ensure casting to double
      reviews: (map['reviews'] as num).toInt(), // Ensure casting to int
      calories: (map['calories'] as num).toInt(), // Ensure casting to int
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'categoryId': categoryId,
      'rating': rating,
      'reviews': reviews,
      'calories': calories,
    };
  }
}
