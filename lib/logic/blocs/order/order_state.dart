// lib/logic/blocs/order/order_state.dart

import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final Order order;

  OrderSuccess({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderFailure extends OrderState {
  final String error;

  OrderFailure({required this.error});

  @override
  List<Object> get props => [error];
}
