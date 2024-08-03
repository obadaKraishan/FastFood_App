import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/order_model.dart';
import 'package:fastfood_app/logic/blocs/order_details/order_details_bloc.dart';
import 'package:fastfood_app/logic/blocs/order_details/order_details_event.dart';
import 'package:fastfood_app/data/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/presentation/screens/profile/order_details_screen.dart';

class OrderListItem extends StatelessWidget {
  final Order order;

  OrderListItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Order #${order.id}', style: TextStyle(color: Colors.white)),
      subtitle: Text('Status: ${order.status}', style: TextStyle(color: Colors.white70)),
      trailing: Icon(Icons.arrow_forward, color: Colors.white),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => OrderDetailsBloc(
                orderRepository: RepositoryProvider.of<OrderRepository>(context),
              )..add(FetchOrderDetails(orderId: order.id)),
              child: OrderDetailsScreen(),
            ),
          ),
        );
      },
    );
  }
}
