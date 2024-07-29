import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_event.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_state.dart';
import 'package:fastfood_app/logic/blocs/user/user_bloc.dart';
import 'package:fastfood_app/logic/blocs/user/user_state.dart';
import 'package:fastfood_app/presentation/widgets/profile_options.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2029), // Dark background color
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF1C2029),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'), // Replace with actual image URL
              radius: 60,
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
                    value: false, // Replace with your state management solution
                    onChanged: (value) {
                      // Handle switch toggle
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
                  foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
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
}
