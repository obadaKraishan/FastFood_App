import 'package:fastfood_app/data/models/drink_model.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';

class DrinkRepository {
  final FirestoreProvider _firestoreProvider;

  DrinkRepository({required FirestoreProvider firestoreProvider})
      : _firestoreProvider = firestoreProvider;

  Stream<List<DrinkModel>> getDrinksByIds(List<String> drinkIds) {
    return _firestoreProvider.getDrinksByIds(drinkIds);
  }
}