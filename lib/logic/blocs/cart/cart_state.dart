import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/cart_model.dart' as cart_model; // Use alias for cart model

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final cart_model.Cart cart;  // Use the correct Cart type

  CartLoaded({required this.cart});

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});

  @override
  List<Object?> get props => [message];
}
