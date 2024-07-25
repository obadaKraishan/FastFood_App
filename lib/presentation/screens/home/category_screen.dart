import 'package:fastfood_app/data/models/category_model.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_bloc.dart';
import 'package:fastfood_app/logic/blocs/category/category_event.dart';
import 'package:fastfood_app/logic/blocs/category/category_state.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(categoryRepository: context.read<CategoryRepository>())..add(LoadCategories()),
      child: Container(
        height: 120, // Increased height for better visibility
        child: BlocBuilder<CategoryBloc, CategoryState>(
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
                  final categories = snapshot.data ?? [];
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35, // Increased radius for better visibility
                              backgroundImage: NetworkImage(category.imageUrl),
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(height: 8),
                            Text(
                              category.name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }
            return Center(child: Text('No categories found', style: TextStyle(color: Colors.white)));
          },
        ),
      ),
    );
  }
}
