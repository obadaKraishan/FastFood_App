import 'package:equatable/equatable.dart';
import 'package:fastfood_app/data/models/category_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryAdded extends CategoryState {}

class CategoryError extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final Stream<List<CategoryModel>> categories;

  CategoryLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}
