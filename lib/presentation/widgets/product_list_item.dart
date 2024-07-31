import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/presentation/screens/home/product_details_screen.dart';

class ProductListItem extends StatelessWidget {
  final ProductModel product;
  final Function incrementCartItemCount;

  ProductListItem({required this.product, required this.incrementCartItemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF2A313F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    productId: product.id,
                    incrementCartItemCount: incrementCartItemCount,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: Text('Details', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
