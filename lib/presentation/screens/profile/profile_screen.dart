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
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {
              // Handle more button action
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return ProfileContent(user: state.user);
          } else if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Failed to load user data', style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final user;

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
