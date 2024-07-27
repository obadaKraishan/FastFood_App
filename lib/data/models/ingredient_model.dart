import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isMandatory;

  IngredientModel({
    required this.id,
    required this.name,
    required this.price,
    required this.isMandatory,
  });

  @override
  List<Object> get props => [id, name, price, isMandatory];

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      isMandatory: map['isMandatory'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isMandatory': isMandatory,
    };
  }
}
