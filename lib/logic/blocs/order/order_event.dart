import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/order_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final Order order;

  CreateOrderEvent({required this.order});

  @override
  List<Object> get props => [order];
}

class LoadOrdersEvent extends OrderEvent {
  final String userId;

  LoadOrdersEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateOrderStatusEvent extends OrderEvent {
  final String orderId;
  final String status;
  final String userId;

  UpdateOrderStatusEvent({required this.orderId, required this.status, required this.userId});

  @override
  List<Object> get props => [orderId, status, userId];
}
