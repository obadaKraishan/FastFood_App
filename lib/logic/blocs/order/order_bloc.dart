import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<CreateOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await orderRepository.createOrder(event.order);
        emit(OrderSuccess(order: event.order));
      } catch (e) {
        emit(OrderFailure(error: e.toString()));
      }
    });
  }
}
