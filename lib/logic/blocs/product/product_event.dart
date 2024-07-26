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
