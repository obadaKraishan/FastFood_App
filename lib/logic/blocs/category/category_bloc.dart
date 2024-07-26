// lib/logic/blocs/category/category_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<SearchCategories>(_onSearchCategories); // Add this line
  }

  void _onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categoriesStream = _categoryRepository.getCategories();
      emit(CategoryLoaded(categories: categoriesStream));
    } catch (_) {
      emit(CategoryError());
    }
  }

  void _onAddCategory(AddCategory event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      await _categoryRepository.addCategory(event.category);
      emit(CategoryAdded());
    } catch (_) {
      emit(CategoryError());
    }
  }

  void _onSearchCategories(SearchCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categoriesStream = _categoryRepository.getCategories();
      final filteredCategoriesStream = categoriesStream.map((categories) =>
          categories.where((category) => category.name.toLowerCase().contains(event.query.toLowerCase())).toList());
      emit(CategoryLoaded(categories: filteredCategoriesStream));
    } catch (_) {
      emit(CategoryError());
    }
  }
}
