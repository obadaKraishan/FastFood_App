import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthProvider({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<User?> signUp(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
