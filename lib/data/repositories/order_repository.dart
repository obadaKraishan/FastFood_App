import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood_app/data/models/order_model.dart' as model;

class OrderRepository {
  final firestore.FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderRepository({firestore.FirebaseFirestore? firestoreInstance, FirebaseAuth? auth})
      : _firestore = firestoreInstance ?? firestore.FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Future<void> createOrder(model.Order order) async {
    await _firestore.collection('orders').doc(order.id).set(order.toMap());
  }

  Future<List<model.Order>> getOrders(String userId) async {
    final snapshot = await _firestore.collection('orders').where('userId', isEqualTo: userId).get();
    return snapshot.docs.map((doc) => model.Order.fromMap(doc.data())).toList();
  }
}
