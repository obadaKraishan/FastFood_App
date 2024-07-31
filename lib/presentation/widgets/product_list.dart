import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/logic/blocs/product/product_state.dart';
import 'package:fastfood_app/presentation/widgets/product_list_item.dart';

class ProductList extends StatelessWidget {
  final Function incrementCartItemCount;

  ProductList({required this.incrementCartItemCount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoaded) {
          return StreamBuilder<List<ProductModel>>(
            stream: state.products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Center(child: Text('Error loading products'));
              }
              if (snapshot.hasData) {
                final products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductListItem(product: product, incrementCartItemCount: incrementCartItemCount);
                  },
                );
              }
              return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
            },
          );
        }
        return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
      },
    );
  }
}
