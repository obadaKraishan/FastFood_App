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
  final Stream<List<ProductModel>>? products;
  final ProductModel? product;

  ProductLoaded({this.products, this.product});

  @override
  List<Object> get props => [products ?? Stream.empty(), product ?? ProductModel(
    id: '',
    name: '',
    price: 0.0,
    imageUrl: '',
    description: '',
    categoryId: '',
    rating: 0.0,
    reviews: 0,
    calories: 0,
    ingredientIds: [],
    addonIds: [],
    drinkIds: [],
  )];
}
