import 'package:cloud_firestore/cloud_firestore.dart';
import 'payment_method_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String gender;
  final Map<String, dynamic> location;
  final List<String> wishlist;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.gender,
    required this.location,
    required this.wishlist,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? gender,
    Map<String, dynamic>? location,
    List<String>? wishlist,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      wishlist: wishlist ?? this.wishlist,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      avatar: data['avatar'],
      gender: data['gender'],
      location: data['location'],
      wishlist: List<String>.from(data['wishlist'] ?? []),
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'gender': gender,
      'location': location,
      'wishlist': wishlist,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
