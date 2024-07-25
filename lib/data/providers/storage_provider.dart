import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageProvider {
  final FirebaseStorage _firebaseStorage;

  StorageProvider({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> uploadFile(File file, String path) async {
    final ref = _firebaseStorage.ref().child(path);
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
