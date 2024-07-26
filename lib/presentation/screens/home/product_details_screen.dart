// lib/presentation/screens/home/product_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/logic/blocs/product/product_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  ProductDetailsScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: context.read<ProductRepository>())
        ..add(LoadProduct(productId: productId)),
      child: Scaffold(
        backgroundColor: Color(0xFF1C2029), // Dark background color
        appBar: AppBar(
          backgroundColor: Color(0xFF1C2029),
          title: Text('Product Details'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoaded && state.product != null) {
              final product = state.product!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product.imageUrl,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < product.rating.round() ? Icons.star : Icons.star_border,
                                color: Colors.yellow,
                                size: 20,
                              );
                            }),
                          ),
                          Text(
                            '(${product.reviews} reviews)',
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        product.description,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nutritional value per 120gm',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1.98', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('15.22', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('30.00', style: TextStyle(fontSize: 16, color: Colors.white70)),
                          Text('8.60', style: TextStyle(fontSize: 16, color: Colors.white70)),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: Center(
                          child: Text('Add to Cart', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(child: Text('Product not found', style: TextStyle(color: Colors.white)));
          },
        ),
      ),
    );
  }
}
