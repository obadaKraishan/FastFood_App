// lib/logic/blocs/order/order_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is CreateOrderEvent) {
      yield OrderLoading();
      try {
        await orderRepository.createOrder(event.order);
        yield OrderSuccess(order: event.order);
      } catch (e) {
        yield OrderFailure(error: e.toString());
      }
    }
  }
}
