import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood_app/data/models/user_model.dart';
import 'package:fastfood_app/data/models/payment_method_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> registerUser(UserModel user, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      user = user.copyWith(id: userCredential.user!.uid);  // Update user with the correct ID
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      print("User data saved to Firestore: ${user.toMap()}");
    } catch (e) {
      print("Error saving user to Firestore: $e");
      rethrow;  // Re-throw the error to handle it in the calling code
    }
  }

  Future<void> loginUser(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      print("Fetching user data for userId: $userId");
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        print("User data found: ${doc.data()}");
        return UserModel.fromFirestore(doc);
      } else {
        print("User not found in Firestore");
        return null;
      }
    } catch (e) {
      print("Error getting user from Firestore: $e");
      return null;
    }
  }

  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updateSelectedPaymentMethod(String userId, PaymentMethod paymentMethod) async {
    await _firestore.collection('users').doc(userId).update({
      'selectedPaymentMethod': paymentMethod.toMap(),
    });
  }
}
