import 'package:fastfood_app/data/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood_app/logic/blocs/order/order_bloc.dart';
import 'package:fastfood_app/logic/blocs/order/order_state.dart';
import 'package:fastfood_app/logic/blocs/order/order_event.dart';
import 'package:fastfood_app/presentation/widgets/order_list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrdersScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          backgroundColor: Color(0xFF1C2029),
        ),
        body: Center(
          child: Text(
            'Please log in to view your orders.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: BlocProvider(
        create: (context) => OrderBloc(orderRepository: context.read<OrderRepository>())
          ..add(LoadOrdersEvent(userId: user.uid)),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OrderLoaded) {
              final orders = state.orders;
              if (orders.isEmpty) {
                return Center(
                  child: Text(
                    'No orders found.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () {
                  BlocProvider.of<OrderBloc>(context).add(LoadOrdersEvent(userId: user.uid));
                  _refreshController.refreshCompleted();
                },
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return OrderListItem(order: order);
                  },
                ),
              );
            } else if (state is OrderError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
