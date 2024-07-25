import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';
import 'package:fastfood_app/data/repositories/category_repository.dart';
import 'package:fastfood_app/data/models/category_model.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is AddCategory) {
      yield* _mapAddCategoryToState(event);
    }
  }

  Stream<CategoryState> _mapAddCategoryToState(AddCategory event) async* {
    try {
      yield CategoryLoading();
      await _categoryRepository.addCategory(event.category);
      yield CategoryAdded();
    } catch (_) {
      yield CategoryError();
    }
  }
}
