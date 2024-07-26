// lib/logic/blocs/product/product_event.dart
import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/product_model.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final ProductModel product;

  AddProduct({required this.product});

  @override
  List<Object> get props => [product];
}

class LoadProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final String productId;

  LoadProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}

class LoadProductsByCategory extends ProductEvent {
  final String categoryId;

  LoadProductsByCategory({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
