// lib/presentation/screens/products/products_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/presentation/widgets/custom_search_bar.dart';
import 'package:fastfood_app/presentation/widgets/filter_tabs.dart';
import 'package:fastfood_app/presentation/widgets/product_list.dart';
import 'package:fastfood_app/logic/blocs/category/category_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_event.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:fastfood_app/data/repositories/product_repository.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: context.read<CategoryRepository>(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            productRepository: context.read<ProductRepository>(),
          )..add(LoadProducts()),
        ),
      ],
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
          title: Text('Popular Now', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilterTabs(),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ProductList(),
            ),
          ],
        ),
      ),
    );
  }
}
