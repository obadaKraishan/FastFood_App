import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'package:fastfood_app/logic/blocs/user/user_bloc.dart';
import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:fastfood_app/logic/blocs/user/user_state.dart';
import 'package:fastfood_app/data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = (context.read<UserBloc>().state as UserLoaded).user;
    _nameController.text = user.name;
    _phoneController.text = user.phone;
    _addressController.text = user.location['address'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            Navigator.pop(context);
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
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
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                  validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserModel updatedUser = UserModel(
                        id: (context.read<UserBloc>().state as UserLoaded).user.id,
                        name: _nameController.text,
                        email: (context.read<UserBloc>().state as UserLoaded).user.email,
                        phone: _phoneController.text,
                        avatar: (context.read<UserBloc>().state as UserLoaded).user.avatar,
                        gender: (context.read<UserBloc>().state as UserLoaded).user.gender,
                        location: {
                          'address': _addressController.text,
                        },
                        wishlist: (context.read<UserBloc>().state as UserLoaded).user.wishlist,
                        createdAt: (context.read<UserBloc>().state as UserLoaded).user.createdAt,
                        updatedAt: Timestamp.now(), // Fix here
                      );
                      context.read<UserBloc>().add(UpdateUser(user: updatedUser));
                    }
                  },
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
