import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAdded extends ProductState {}

class ProductError extends ProductState {}

class ProductLoaded extends ProductState {
  final Stream<List<ProductModel>> products;

  ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}
