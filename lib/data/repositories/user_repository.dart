import 'package:fastfood_app/data/models/user_model.dart';
import 'package:fastfood_app/data/providers/firestore_provider.dart';

class UserRepository {
  final FirestoreProvider _firestoreProvider;

  UserRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<void> addUser(UserModel user) async {
    await _firestoreProvider.addUser(user.toMap());
  }
}
