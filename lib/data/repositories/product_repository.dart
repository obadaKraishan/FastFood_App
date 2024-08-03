import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/data/models/product_model.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';

class ProductRepository {
  final FirestoreProvider _firestoreProvider;

  ProductRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<void> addProduct(ProductModel product) async {
    await _firestoreProvider.addProduct(product);
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestoreProvider.updateProduct(product);
  }

  Future<void> deleteProduct(String productId) async {
    await _firestoreProvider.deleteProduct(productId);
  }

  Stream<List<ProductModel>> getProducts() {
    return _firestoreProvider.getProducts();
  }

  Future<ProductModel> getProductById(String productId) async {
    DocumentSnapshot doc = await _firestoreProvider.getProductById(productId);
    // Ensure the document exists and the data can be cast to a Map
    if (doc.exists) {
      return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception('Product not found');
    }
  }

  Stream<List<ProductModel>> getProductsByCategory(String categoryId) {
    return _firestoreProvider.getProductsByCategory(categoryId);
  }
}
