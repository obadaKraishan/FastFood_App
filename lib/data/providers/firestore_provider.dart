import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/data/models/addon_model.dart';
import 'package:fastfood_app/data/models/category_model.dart';
import 'package:fastfood_app/data/models/drink_model.dart';
import 'package:fastfood_app/data/models/ingredient_model.dart';
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

  Stream<List<ProductModel>> getProductsByCategory(String categoryId) {
    return _firestore
        .collection('products')
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<ProductModel> getProductById(String productId) async {
    final doc = await _firestore.collection('products').doc(productId).get();
    return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Stream<List<IngredientModel>> getIngredientsByProduct(String productId) {
    print('Fetching ingredients for product ID: $productId');
    return _firestore
        .collection('ingredients')
        .where('productIds', arrayContains: productId)
        .snapshots()
        .map((snapshot) {
      print('Ingredients fetched: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Ingredient: ${doc.data()}');
        return IngredientModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<DrinkModel>> getDrinksByProduct(String productId) {
    print('Fetching drinks for product ID: $productId');
    return _firestore
        .collection('drinks')
        .where('productIds', arrayContains: productId)
        .snapshots()
        .map((snapshot) {
      print('Drinks fetched: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Drink: ${doc.data()}');
        return DrinkModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<AddonModel>> getAddonsByProduct(String productId) {
    print('Fetching add-ons for product ID: $productId');
    return _firestore
        .collection('addons')
        .where('productIds', arrayContains: productId)
        .snapshots()
        .map((snapshot) {
      print('Add-ons fetched: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Addon: ${doc.data()}');
        return AddonModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
