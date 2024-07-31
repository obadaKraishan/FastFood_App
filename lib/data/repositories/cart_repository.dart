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
}
