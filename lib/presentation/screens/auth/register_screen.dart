import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_bloc.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_event.dart';
import 'package:fastfood_app/logic/blocs/auth/auth_state.dart';
import 'package:fastfood_app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushNamed(context, '/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Failed')));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone',
                      ),
                      initialCountryCode: 'US',
                      onChanged: (phone) {
                        setState(() {
                          _phoneNumber = phone.completeNumber;
                        });
                      },
                      validator: (value) {
                        if (_phoneNumber == null || _phoneNumber!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          UserModel user = UserModel(
                            id: '',
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneNumber!,
                            avatar: '',
                            gender: '',
                            location: {},
                            wishlist: [],
                            createdAt: Timestamp.now(),
                            updatedAt: Timestamp.now(),
                          );
                          debugPrint('User data: ${user.toMap()}');
                          context.read<AuthBloc>().add(AuthSignUp(
                            email: user.email,
                            password: _passwordController.text,
                          ));
                        }
                      },
                      child: Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
