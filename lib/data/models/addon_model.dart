import 'package:equatable/equatable.dart';

class AddonModel extends Equatable {
  final String id;
  final String name;
  final double price;

  AddonModel({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  List<Object> get props => [id, name, price];

  factory AddonModel.fromMap(Map<String, dynamic> map) {
    return AddonModel(
      id: map['id'],
      name: map['name'],
      price: (map['price'] is num) ? (map['price'] as num).toDouble() : double.parse(map['price']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
