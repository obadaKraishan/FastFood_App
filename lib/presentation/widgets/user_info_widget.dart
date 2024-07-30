import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserInfoWidget extends StatefulWidget {
  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  String? _avatarUrl;

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return _buildGuestView();
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return _buildGuestView();
        }

        var userData = snapshot.data!.data();

        if (userData == null) {
          return _buildGuestView();
        }

        _avatarUrl = userData['avatar'];

        return Row(
          children: [
            GestureDetector(
              onTap: currentUser != null ? _pickImage : _promptLogin,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: _getImageProvider(_avatarUrl),
                child: _avatarUrl == null || _avatarUrl!.isEmpty
                    ? Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 10,
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 12),
                  ),
                )
                    : null,
              ),
            ),
            SizedBox(width: 10),
            _buildUserName(userData['name'] ?? 'User'),
            Spacer(),
            Icon(Icons.notifications, color: Colors.white),
          ],
        );
      },
    );
  }

  Widget _buildGuestView() {
    return Row(
      children: [
        _buildDefaultAvatar(),
        SizedBox(width: 10),
        _buildUserName('Guest'),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return GestureDetector(
      onTap: _promptLogin,
      child: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage('assets/images/onboarding/delivery_person.png'),
      ),
    );
  }

  Widget _buildUserName(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome',
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        Text(
          name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload the image to the server and get the URL
      String uploadedUrl = await uploadImageToServer(File(pickedFile.path));

      setState(() {
        _avatarUrl = uploadedUrl;
      });

      // Update Firestore document with the new avatar URL
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'avatar': _avatarUrl});
    }
  }

  Future<void> _promptLogin() async {
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<String> uploadImageToServer(File image) async {
    // Implement your image upload logic here
    // For now, return the local path as a placeholder
    return image.path;
  }

  ImageProvider _getImageProvider(String? avatarUrl) {
    if (avatarUrl == null || avatarUrl.isEmpty) {
      return AssetImage('assets/images/onboarding/delivery_person.png');
    } else if (avatarUrl.startsWith('http') || avatarUrl.startsWith('https')) {
      return NetworkImage(avatarUrl);
    } else {
      return FileImage(File(avatarUrl));
    }
  }
}
