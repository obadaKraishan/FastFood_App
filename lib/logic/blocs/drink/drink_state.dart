import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/drink_model.dart';

abstract class DrinkState extends Equatable {
  const DrinkState();

  @override
  List<Object> get props => [];
}

class DrinkInitial extends DrinkState {}

class DrinkLoading extends DrinkState {}

class DrinkLoaded extends DrinkState {
  final List<DrinkModel> drinks;

  const DrinkLoaded({required this.drinks});

  @override
  List<Object> get props => [drinks];
}

class DrinkError extends DrinkState {}
