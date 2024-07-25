import 'package:fastfood_app/data/providers/firestore_provider.dart';
import 'package:fastfood_app/data/models/product_model.dart';

class ProductRepository {
  final FirestoreProvider _firestoreProvider;

  ProductRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<void> addProduct(ProductModel product) async {
    await _firestoreProvider.addProduct(product.toMap());
  }
}
