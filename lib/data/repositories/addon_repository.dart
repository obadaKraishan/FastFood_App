import 'package:fastfood_app/data/models/addon_model.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';

class AddonRepository {
  final FirestoreProvider _firestoreProvider;

  AddonRepository({required FirestoreProvider firestoreProvider})
      : _firestoreProvider = firestoreProvider;

  Stream<List<AddonModel>> getAddonsByProduct(String productId) {
    return _firestoreProvider.getAddonsByProduct(productId);
  }
}
