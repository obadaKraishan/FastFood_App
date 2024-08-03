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

  Future<model.Order> getOrderById(String orderId) async {
    final doc = await _firestore.collection('orders').doc(orderId).get();
    return model.Order.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({'status': status});
  }
}
