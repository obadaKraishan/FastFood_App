import 'package:fastfood_app/data/providers/firestore_provider.dart';
import 'package:fastfood_app/data/models/category_model.dart';

class CategoryRepository {
  final FirestoreProvider _firestoreProvider;

  CategoryRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<void> addCategory(CategoryModel category) async {
    await _firestoreProvider.addCategory(category.toMap());
  }
}
