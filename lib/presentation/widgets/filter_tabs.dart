// lib/presentation/widgets/filter_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_state.dart';
import 'package:fastfood_app/logic/blocs/product/product_bloc.dart';
import 'package:fastfood_app/logic/blocs/product/product_event.dart';
import 'package:fastfood_app/data/models/category_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterTabs extends StatefulWidget {
  @override
  _FilterTabsState createState() => _FilterTabsState();
}

class _FilterTabsState extends State<FilterTabs> {
  String activeCategoryId = 'all';

  // Mapping category icon names to actual icons
  final Map<String, IconData> categoryIcons = {
    'appetizers': FontAwesomeIcons.utensils,
    'burger': FontAwesomeIcons.hamburger,
    'chicken': FontAwesomeIcons.drumstickBite,
    'drinks': FontAwesomeIcons.wineGlassAlt,
    'pizza': FontAwesomeIcons.pizzaSlice,
    'shawerma': FontAwesomeIcons.breadSlice,
    'sushi': FontAwesomeIcons.fish,
    'sweets': FontAwesomeIcons.iceCream,
    'salads': FontAwesomeIcons.bowlFood,
    'all': Icons.category,
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategoryLoaded) {
          final categories = state.categories; // Directly get the list of categories
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
                          categoryIcons['all'],
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
                            categoryIcons[category.icon] ?? Icons.category,
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
        }
        return Center(child: Text('Error loading categories'));
      },
    );
  }
}
