import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood_app/data/models/cart_item_model.dart';
import 'package:fastfood_app/data/models/cart_model.dart';

class CartRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  CartRepository({required this.firestore, required this.firebaseAuth});

  Future<Cart> getCart() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final snapshot = await firestore.collection('users').doc(user.uid).collection('cart').get();
    final items = snapshot.docs.map((doc) => CartItem.fromMap(doc.data() as Map<String, dynamic>)).toList();
    return Cart(userId: user.uid, items: items);
  }

  Future<void> updateCart(Cart cart) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final batch = firestore.batch();

    final cartCollection = firestore.collection('users').doc(user.uid).collection('cart');
    for (var item in cart.items) {
      final docRef = cartCollection.doc(item.id);
      batch.set(docRef, item.toMap());
    }

    await batch.commit();
  }

  Future<void> addItemToCart(CartItem cartItem) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    print('User ID: ${user.uid}');
    await firestore.collection('users').doc(user.uid).collection('cart').doc(cartItem.id).set(cartItem.toMap())
        .then((_) {
      print('Item added to cart successfully');
    })
        .catchError((error) {
      print('Failed to add item to cart: $error');
    });
  }

  Future<void> removeItemFromCart(String productId) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final cartItemRef = firestore.collection('users').doc(user.uid).collection('cart').where('productId', isEqualTo: productId);
    final cartItem = await cartItemRef.get();
    for (var doc in cartItem.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> updateCartItem(CartItem cartItem) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    await firestore.collection('users').doc(user.uid).collection('cart').doc(cartItem.id).update(cartItem.toMap());
  }

  Future<void> clearCart(String userId) async {
    final cartItems = await firestore.collection('users').doc(userId).collection('cart').get();
    for (var doc in cartItems.docs) {
      await doc.reference.delete();
    }
  }
}
