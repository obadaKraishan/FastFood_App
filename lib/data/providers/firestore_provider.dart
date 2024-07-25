import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore;

  FirestoreProvider({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addUser(Map<String, dynamic> userData) async {
    await _firestore.collection('users').add(userData);
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    await _firestore.collection('products').add(productData);
  }

  Future<void> addCategory(Map<String, dynamic> categoryData) async {
    await _firestore.collection('categories').add(categoryData);
  }
}
