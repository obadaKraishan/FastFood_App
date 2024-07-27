import 'package:flutter_bloc/flutter_bloc.dart';
import 'drink_event.dart';
import 'drink_state.dart';
import 'package:fastfood_app/data/repositories/drink_repository.dart';

class DrinkBloc extends Bloc<DrinkEvent, DrinkState> {
  final DrinkRepository _drinkRepository;

  DrinkBloc({required DrinkRepository drinkRepository})
      : _drinkRepository = drinkRepository,
        super(DrinkInitial()) {
    on<LoadDrinksByProduct>(_onLoadDrinksByProduct);
  }

  void _onLoadDrinksByProduct(LoadDrinksByProduct event, Emitter<DrinkState> emit) async {
    emit(DrinkLoading());
    try {
      final drinks = await _drinkRepository.getDrinksByIds(event.drinkIds).first;
      emit(DrinkLoaded(drinks: drinks));
    } catch (_) {
      emit(DrinkError());
    }
  }
}
