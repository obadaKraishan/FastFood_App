import 'package:equatable/equatable.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class LoadIngredientsByProduct extends IngredientEvent {
  final List<String> ingredientIds;

  const LoadIngredientsByProduct({required this.ingredientIds});

  @override
  List<Object> get props => [ingredientIds];
}
