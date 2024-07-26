import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/logic/blocs/product/product_state.dart';
import 'package:fastfood_app/presentation/widgets/quantity_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  ProductDetailsScreen({required this.productId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: context.read<ProductRepository>())
        ..add(LoadProduct(productId: widget.productId)),
      child: Scaffold(
        backgroundColor: Color(0xFF1C2029), // Dark background color
        appBar: AppBar(
          backgroundColor: Color(0xFF1C2029),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Product Details', style: TextStyle(color: Colors.white)),
          centerTitle: true,
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
                            height: 380,
                            fit: BoxFit.contain,
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
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
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
                        style: TextStyle(fontSize: 22, color: Colors.white70),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QuantityButton(
                            icon: Icons.remove,
                            onPressed: _decrementQuantity,
                          ),
                          Text(
                            '$_quantity',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          QuantityButton(
                            icon: Icons.add,
                            onPressed: _incrementQuantity,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
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
