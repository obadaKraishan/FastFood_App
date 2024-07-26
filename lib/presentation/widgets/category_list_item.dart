// lib/presentation/widgets/category_list_item.dart
import 'package:flutter/material.dart';
import 'package:fastfood_app/data/models/category_model.dart';
import 'package:fastfood_app/presentation/screens/products/products_screen.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryModel category;

  CategoryListItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsScreen(categoryId: category.id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0), // Add padding here
        decoration: BoxDecoration(
          color: Color(0xFF2A313F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              category.imageUrl,
              height: 110,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsScreen(categoryId: category.id),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: Text(
                  'Explore',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
