import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/repositories/order_repository.dart';
import 'order_details_event.dart';
import 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final OrderRepository orderRepository;

  OrderDetailsBloc({required this.orderRepository}) : super(OrderDetailsInitial()) {
    on<FetchOrderDetails>((event, emit) async {
      emit(OrderDetailsLoading());
      try {
        final order = await orderRepository.getOrderById(event.orderId);
        emit(OrderDetailsLoaded(order: order));
      } catch (e) {
        emit(OrderDetailsError(message: e.toString()));
      }
    });

    on<UpdateOrderStatus>((event, emit) async {
      emit(OrderDetailsLoading());
      try {
        await orderRepository.updateOrderStatus(event.orderId, event.status);
        final updatedOrder = await orderRepository.getOrderById(event.orderId);
        emit(OrderDetailsLoaded(order: updatedOrder));
      } catch (e) {
        emit(OrderDetailsError(message: e.toString()));
      }
    });
  }
}
