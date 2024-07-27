import 'package:equatable/equatable.dart';

class DrinkModel extends Equatable {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  DrinkModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, name, price, imageUrl];

  factory DrinkModel.fromMap(Map<String, dynamic> map) {
    return DrinkModel(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
