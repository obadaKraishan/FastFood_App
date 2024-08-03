import 'package:equatable/equatable.dart';

abstract class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderDetails extends OrderDetailsEvent {
  final String orderId;

  const FetchOrderDetails({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class UpdateOrderStatus extends OrderDetailsEvent {
  final String orderId;
  final String status;

  const UpdateOrderStatus({required this.orderId, required this.status});

  @override
  List<Object> get props => [orderId, status];
}
