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
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Container(
                                  width: 80.0, // 2 * radius
                                  height: 80.0, // 2 * radius
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(category.imageUrl),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
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
