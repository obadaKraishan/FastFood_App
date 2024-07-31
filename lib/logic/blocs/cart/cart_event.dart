import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;

  AddToCart({required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final String productId;

  RemoveFromCart({required this.productId});

  @override
  List<Object> get props => [productId];
}

class UpdateCartItem extends CartEvent {
  final CartItem item;

  UpdateCartItem({required this.item});

  @override
  List<Object> get props => [item];
}

class ClearCart extends CartEvent {}
