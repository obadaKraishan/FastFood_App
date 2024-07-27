import 'package:flutter_bloc/flutter_bloc.dart';
import 'ingredient_event.dart';
import 'ingredient_state.dart';
import 'package:fastfood_app/data/repositories/ingredient_repository.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientRepository _ingredientRepository;

  IngredientBloc({required IngredientRepository ingredientRepository})
      : _ingredientRepository = ingredientRepository,
        super(IngredientInitial()) {
    on<LoadIngredientsByProduct>(_onLoadIngredientsByProduct);
  }

  void _onLoadIngredientsByProduct(LoadIngredientsByProduct event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading());
    try {
      final ingredients = await _ingredientRepository.getIngredientsByProduct(event.productId).first;
      emit(IngredientLoaded(ingredients: ingredients));
    } catch (_) {
      emit(IngredientError());
    }
  }
}
