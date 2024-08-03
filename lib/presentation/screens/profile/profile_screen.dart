import 'package:fastfood_app/data/models/user_model.dart';
import 'package:fastfood_app/data/repositories/user_repository.dart';
import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_event.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_state.dart';
import 'package:fastfood_app/logic/blocs/user/user_bloc.dart';
import 'package:fastfood_app/logic/blocs/user/user_state.dart';
import 'package:fastfood_app/presentation/widgets/profile_options.dart';
import 'package:provider/provider.dart';
import 'package:fastfood_app/presentation/utils/theme_provider.dart';
import 'dart:io';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          if (user == null) {
            return _buildGuestView(context);
          } else {
            return _buildUserView(context, user.uid);
          }
        },
      ),
    );
  }

  Widget _buildGuestView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/food_placeholder.png', height: 380),
            SizedBox(height: 20),
            Text(
              'Feeling hungry? Join us now to order your favorite food!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF81171b),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Login', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF2A313F),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Register', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserView(BuildContext context, String userId) {
    print("Fetching user view for userId: $userId");
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(userRepository: UserRepository())..add(LoadUser(userId: userId)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          print("User State: $state");
          if (state is UserLoaded) {
            return ProfileContent(user: state.user);
          } else if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildGuestView(context); // Show guest view if there's an error or no data
          }
        },
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final UserModel user;

  ProfileContent({required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile');
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage: user.avatar != null && user.avatar.isNotEmpty
                    ? _getImageProvider(user.avatar)
                    : AssetImage('assets/images/profile.png') as ImageProvider,
                child: user.avatar == null || user.avatar.isEmpty
                    ? Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 20,
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                )
                    : null,
              ),
            ),
            SizedBox(height: 10),
            Text(
              user.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              user.email,
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 20),
            ProfileOptions(),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2A313F),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(color: Colors.white),
                  ),
                  Switch(
                    value: Provider.of<ThemeProvider>(context).isDarkMode,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthSignOut());
                  Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Log Out', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String avatarUrl) {
    if (avatarUrl.startsWith('http') || avatarUrl.startsWith('https')) {
      return NetworkImage(avatarUrl);
    } else {
      return FileImage(File(avatarUrl));
    }
  }
}
