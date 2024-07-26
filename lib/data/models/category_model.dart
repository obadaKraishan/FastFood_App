// lib/data/models/category_model.dart
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.icon,
  });

  @override
  List<Object> get props => [id, name, imageUrl, icon];

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      icon: map['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'icon': icon,
    };
  }
}
