// lib/presentation/widgets/filter_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_state.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/data/models/category_model.dart';

class FilterTabs extends StatefulWidget {
  @override
  _FilterTabsState createState() => _FilterTabsState();
}

class _FilterTabsState extends State<FilterTabs> {
  String activeCategoryId = 'all';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategoryLoaded) {
          return StreamBuilder<List<CategoryModel>>(
            stream: state.categories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error loading categories'));
              }
              if (snapshot.hasData) {
                final categories = snapshot.data ?? [];
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activeCategoryId = 'all';
                          });
                          context.read<ProductBloc>().add(LoadProducts());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.category,
                                color: activeCategoryId == 'all' ? Colors.redAccent : Colors.white,
                                size: 24,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'All',
                                style: TextStyle(
                                  color: activeCategoryId == 'all' ? Colors.redAccent : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      for (var category in categories)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              activeCategoryId = category.id;
                            });
                            context.read<ProductBloc>().add(
                              LoadProductsByCategory(categoryId: category.id),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.category,
                                  color: activeCategoryId == category.id ? Colors.redAccent : Colors.white,
                                  size: 24,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    color: activeCategoryId == category.id ? Colors.redAccent : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('No categories found'));
              }
            },
          );
        }
        return Center(child: Text('Error loading categories'));
      },
    );
  }
}
