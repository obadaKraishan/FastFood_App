import 'package:fastfood_app/data/models/category_model.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';

class CategoryRepository {
  final FirestoreProvider _firestoreProvider;

  CategoryRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<void> addCategory(CategoryModel category) async {
    await _firestoreProvider.addCategory(category);
  }

  Future<void> updateCategory(CategoryModel category) async {
    await _firestoreProvider.updateCategory(category);
  }

  Future<void> deleteCategory(String categoryId) async {
    await _firestoreProvider.deleteCategory(categoryId);
  }

  Stream<List<CategoryModel>> getCategories() {
    return _firestoreProvider.getCategories();
  }
}
