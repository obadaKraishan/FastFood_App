import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String userId;
  final List<Map<String, dynamic>> orderItems;
  final double totalPrice;
  final String status;
  final Timestamp createdAt;
  final Timestamp estimatedDeliveryTime;
  final String paymentMethod;
  final String deliveryAddress;
  final String note;  // New field for order note

  Order({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.estimatedDeliveryTime,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.note,  // New field for order note
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'orderItems': orderItems,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': createdAt,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress,
      'note': note,  // New field for order note
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['userId'],
      orderItems: List<Map<String, dynamic>>.from(map['orderItems']),
      totalPrice: map['totalPrice'],
      status: map['status'],
      createdAt: map['createdAt'],
      estimatedDeliveryTime: map['estimatedDeliveryTime'],
      paymentMethod: map['paymentMethod'],
      deliveryAddress: map['deliveryAddress'],
      note: map['note'],  // New field for order note
    );
  }
}
