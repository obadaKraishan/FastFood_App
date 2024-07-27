import 'package:equatable/equatable.dart';

abstract class DrinkEvent extends Equatable {
  const DrinkEvent();

  @override
  List<Object> get props => [];
}

class LoadDrinksByProduct extends DrinkEvent {
  final String productId;

  const LoadDrinksByProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}
