import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/data/models/addon_model.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/data/models/category_model.dart';
import 'package:fastfood_app/data/models/drink_model.dart';
import 'package:fastfood_app/data/models/ingredient_model.dart';
import 'package:fastfood_app/data/models/product_model.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore;

  FirestoreProvider({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _firestore;

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

  Stream<List<IngredientModel>> getIngredientsByIds(List<String> ingredientIds) {
    print('Fetching ingredients for IDs: $ingredientIds');
    return _firestore
        .collection('ingredients')
        .where(FieldPath.documentId, whereIn: ingredientIds)
        .snapshots()
        .map((snapshot) {
      print('Ingredients fetched: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Ingredient: ${doc.data()}');
        return IngredientModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<DrinkModel>> getDrinksByIds(List<String> drinkIds) {
    print('Fetching drinks for IDs: $drinkIds');
    return _firestore
        .collection('drinks')
        .where(FieldPath.documentId, whereIn: drinkIds)
        .snapshots()
        .map((snapshot) {
      print('Drinks fetched: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Drink: ${doc.data()}');
        return DrinkModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<AddonModel>> getAddonsByIds(List<String> addonIds) {
    print('Fetching add-ons for IDs: $addonIds');
    return _firestore
        .collection('addons')
        .where(FieldPath.documentId, whereIn: addonIds)
        .snapshots()
        .map((snapshot) {
      print('Add-ons fetched: ${snapshot.docs.length}');
      snapshot.docs.forEach((doc) {
        print('Addon data: ${doc.data()}');
      });
      return snapshot.docs.map((doc) {
        return AddonModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Cart methods
  Future<void> addItemToCart(String userId, CartItem cartItem) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartItem.id)
        .set(cartItem.toMap());
  }

  Future<void> updateCartItem(String userId, CartItem cartItem) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartItem.id)
        .update(cartItem.toMap());
  }

  Future<void> removeItemFromCart(String userId, String cartItemId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartItemId)
        .delete();
  }

  Stream<List<CartItem>> getCartItems(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CartItem.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
