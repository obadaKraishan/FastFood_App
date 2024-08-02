import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/order_model.dart';
import 'package:fastfood_app/logic/blocs/order/order_bloc.dart';
import 'package:fastfood_app/logic/blocs/order/order_state.dart'; // Ensure this import
import 'package:fastfood_app/presentation/widgets/order_list_item.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            final orders = state.orders;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderListItem(order: order);
              },
            );
          } else if (state is OrderError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
