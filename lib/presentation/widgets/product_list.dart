// lib/presentation/widgets/product_list.dart
import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/product_model.dart'; // Assume you have this model
import 'package:fastfood_app/data/repositories/product_repository.dart'; // Assume you have this repository
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/logic/blocs/product/product_state.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: context.read<ProductRepository>())
        ..add(LoadProducts()),
      child: BlocBuilder<ProductBloc, ProductState>(
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
                      return ListTile(
                        leading: Image.network(product.imageUrl, fit: BoxFit.cover),
                        title: Text(product.name, style: TextStyle(color: Colors.white)),
                        subtitle: Text('\$${product.price}', style: TextStyle(color: Colors.white70)),
                      );
                    },
                  );
                }
                return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
              },
            );
          }
          return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
        },
      ),
    );
  }
}
