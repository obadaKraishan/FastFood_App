// lib/logic/blocs/category/category_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:fastfood_app/data/models/category_model.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  List<CategoryModel> _allCategories = [];

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<SearchCategories>(_onSearchCategories);
  }

  void _onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await _categoryRepository.getCategories().first;
      _allCategories = categories;
      emit(CategoryLoaded(categories: categories));
    } catch (_) {
      emit(CategoryError());
    }
  }

  void _onAddCategory(AddCategory event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      await _categoryRepository.addCategory(event.category);
      final categories = await _categoryRepository.getCategories().first;
      _allCategories = categories;
      emit(CategoryLoaded(categories: categories));
    } catch (_) {
      emit(CategoryError());
    }
  }

  void _onSearchCategories(SearchCategories event, Emitter<CategoryState> emit) {
    final query = event.query.toLowerCase();
    final filteredCategories = _allCategories.where((category) {
      return category.name.toLowerCase().contains(query);
    }).toList();
    emit(CategoryLoaded(categories: filteredCategories));
  }
}
