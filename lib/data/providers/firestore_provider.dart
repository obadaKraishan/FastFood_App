// lib/data/providers/firestore_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/data/models/category_model.dart';
import 'package:fastfood_app/data/models/product_model.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore;

  FirestoreProvider({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addCategory(CategoryModel category) async {
    await _firestore.collection('categories').doc(category.id).set(category.toMap());
  }

  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('products').doc(product.id).set(product.toMap());
  }

  Future<void> updateCategory(CategoryModel category) async {
    await _firestore.collection('categories').doc(category.id).update(category.toMap());
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestore.collection('products').doc(product.id).update(product.toMap());
  }

  Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection('categories').doc(categoryId).delete();
  }

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  Stream<List<CategoryModel>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CategoryModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<ProductModel>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<ProductModel> getProductById(String productId) async {
    final doc = await _firestore.collection('products').doc(productId).get();
    return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}
