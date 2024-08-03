import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/order_model.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  final Order order;

  const OrderDetailsLoaded({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderDetailsError extends OrderDetailsState {
  final String message;

  const OrderDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
