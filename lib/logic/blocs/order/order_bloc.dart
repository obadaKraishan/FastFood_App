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
        emit(OrderError(message: e.toString()));
      }
    });

    on<LoadOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await orderRepository.getOrders(event.userId);
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });

    on<UpdateOrderStatusEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await orderRepository.updateOrderStatus(event.orderId, event.status);
        final orders = await orderRepository.getOrders(event.userId); // Ensure the orders are reloaded
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });
  }
}
