// lib/presentation/screens/categories/categories_screen.dart
import 'package:fastfood_app/data/models/category_model.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/presentation/widgets/custom_search_bar.dart';
import 'package:fastfood_app/logic/blocs/category/category_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_state.dart';
import 'package:fastfood_app/logic/blocs/category/category_event.dart';
import 'package:fastfood_app/presentation/widgets/category_list_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2029), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF1C2029),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Categories', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CategoryBloc(
          categoryRepository: context.read<CategoryRepository>(),
        )..add(LoadCategories()),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomSearchBar(
                    onSearch: (query) {
                      context.read<CategoryBloc>().add(SearchCategories(query: query));
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is CategoryLoaded) {
                        final categories = state.categories;
                        if (categories.isEmpty) {
                          return Center(child: Text('No categories found', style: TextStyle(color: Colors.white)));
                        }
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CategoryListItem(category: category);
                          },
                        );
                      }
                      return Center(child: Text('Error loading categories', style: TextStyle(color: Colors.white)));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
