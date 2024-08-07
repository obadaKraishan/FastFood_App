import 'package:fastfood_app/data/models/ingredient_model.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';

class IngredientRepository {
  final FirestoreProvider _firestoreProvider;

  IngredientRepository({required FirestoreProvider firestoreProvider})
      : _firestoreProvider = firestoreProvider;

  Stream<List<IngredientModel>> getIngredientsByIds(List<String> ingredientIds) {
    return _firestoreProvider.getIngredientsByIds(ingredientIds);
  }
}
