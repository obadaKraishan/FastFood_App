// lib/logic/blocs/category/category_event.dart
import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/category_model.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddCategory extends CategoryEvent {
  final CategoryModel category;

  AddCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class LoadCategories extends CategoryEvent {}

class SearchCategories extends CategoryEvent {
  final String query;

  SearchCategories({required this.query});

  @override
  List<Object> get props => [query];
}
