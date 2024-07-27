import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/ingredient_model.dart';

abstract class IngredientState extends Equatable {
  const IngredientState();

  @override
  List<Object> get props => [];
}

class IngredientInitial extends IngredientState {}

class IngredientLoading extends IngredientState {}

class IngredientLoaded extends IngredientState {
  final List<IngredientModel> ingredients;

  const IngredientLoaded({required this.ingredients});

  @override
  List<Object> get props => [ingredients];
}

class IngredientError extends IngredientState {}
