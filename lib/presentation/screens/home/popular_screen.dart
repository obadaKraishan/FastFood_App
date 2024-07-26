// lib/presentation/screens/home/popular_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/logic/blocs/product/product_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'product_details_screen.dart';

class PopularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: context.read<ProductRepository>())..add(LoadProducts()),
      child: Container(
        height: 380, // Adjusted height for better visibility
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
                    print('Fetched products: $products');
                    if (products.isEmpty) {
                      return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        print('Product: ${product.name}');
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(productId: product.id),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFF2A313F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(product.imageUrl, height: 160, width: 200, fit: BoxFit.contain),
                                      ),
                                      Positioned(
                                        right: 8,
                                        top: 8,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(Icons.favorite, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        Text(
                                          product.description.length > 40
                                              ? product.description.substring(0, 40) + '...'
                                              : product.description,
                                          style: TextStyle(fontSize: 14, color: Colors.white70),
                                        ),
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        Row(
                                          children: List.generate(5, (index) {
                                            return Icon(
                                              index < product.rating.round() ? Icons.star : Icons.star_border,
                                              color: Colors.yellow,
                                              size: 16,
                                            );
                                          }),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${product.calories} kcl',
                                          style: TextStyle(fontSize: 12, color: Colors.white70),
                                        ),
                                        SizedBox(height: 8),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.redAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.shoppingCart,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  'Add',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
                  }
                },
              );
            }
            return Center(child: Text('No products found', style: TextStyle(color: Colors.white)));
          },
        ),
      ),
    );
  }
}
