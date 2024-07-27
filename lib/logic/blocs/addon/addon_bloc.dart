import 'package:flutter_bloc/flutter_bloc.dart';
import 'addon_event.dart';
import 'addon_state.dart';
import 'package:fastfood_app/data/repositories/addon_repository.dart';

class AddonBloc extends Bloc<AddonEvent, AddonState> {
  final AddonRepository _addonRepository;

  AddonBloc({required AddonRepository addonRepository})
      : _addonRepository = addonRepository,
        super(AddonInitial()) {
    on<LoadAddonsByProduct>(_onLoadAddonsByProduct);
  }

  void _onLoadAddonsByProduct(LoadAddonsByProduct event, Emitter<AddonState> emit) async {
    emit(AddonLoading());
    try {
      final addons = await _addonRepository.getAddonsByProduct(event.productId).first;
      emit(AddonLoaded(addons: addons));
    } catch (_) {
      emit(AddonError());
    }
  }
}
