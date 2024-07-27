import 'package:equatable/equatable.dart';

abstract class DrinkEvent extends Equatable {
  const DrinkEvent();

  @override
  List<Object> get props => [];
}

class LoadDrinks extends DrinkEvent {}

class LoadDrinksByProduct extends DrinkEvent {
  final List<String> drinkIds;

  const LoadDrinksByProduct({required this.drinkIds});

  @override
  List<Object> get props => [drinkIds];
}
