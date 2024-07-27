import 'package:equatable/equatable.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class LoadIngredientsByProduct extends IngredientEvent {
  final String productId;

  const LoadIngredientsByProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}
