import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/logic/blocs/user/user_bloc.dart';
import 'package:fastfood_app/logic/blocs/user/user_event.dart';
import 'package:fastfood_app/logic/blocs/user/user_state.dart';
import 'package:fastfood_app/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  String? _selectedGender;
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    final user = (context.read<UserBloc>().state as UserLoaded).user;
    _nameController.text = user.name;
    _phoneController.text = user.phone;
    _addressController.text = user.location['address'] ?? '';
    _cityController.text = user.location['city'] ?? '';
    _stateController.text = user.location['state'] ?? '';
    _countryController.text = user.location['country'] ?? '';
    _selectedGender = user.gender;
    _avatarUrl = user.avatar;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarUrl = pickedFile.path;
      });
      // Here you should upload the image to a server and get the URL to save in Firestore
    }
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _avatarUrl != null
                          ? FileImage(File(_avatarUrl!))
                          : NetworkImage('assets/images/profile.png') as ImageProvider,
                      child: _avatarUrl == null
                          ? Icon(Icons.camera_alt, color: Colors.white, size: 30)
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                    validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                  ),
                  SizedBox(height: 10),
                  _buildGenderSelector(),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(labelText: 'City'),
                    validator: (value) => value!.isEmpty ? 'Please enter your city' : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _stateController,
                    decoration: InputDecoration(labelText: 'State'),
                    validator: (value) => value!.isEmpty ? 'Please enter your state' : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _countryController,
                    decoration: InputDecoration(labelText: 'Country'),
                    validator: (value) => value!.isEmpty ? 'Please enter your country' : null,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          UserModel updatedUser = UserModel(
                            id: (context.read<UserBloc>().state as UserLoaded).user.id,
                            name: _nameController.text,
                            email: (context.read<UserBloc>().state as UserLoaded).user.email,
                            phone: _phoneController.text,
                            avatar: _avatarUrl ?? (context.read<UserBloc>().state as UserLoaded).user.avatar,
                            gender: _selectedGender ?? (context.read<UserBloc>().state as UserLoaded).user.gender,
                            location: {
                              'address': _addressController.text,
                              'city': _cityController.text,
                              'state': _stateController.text,
                              'country': _countryController.text,
                            },
                            wishlist: (context.read<UserBloc>().state as UserLoaded).user.wishlist,
                            createdAt: (context.read<UserBloc>().state as UserLoaded).user.createdAt,
                            updatedAt: Timestamp.now(),
                          );
                          context.read<UserBloc>().add(UpdateUser(user: updatedUser));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Update Profile', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: TextStyle(color: Colors.white70)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Male', style: TextStyle(color: Colors.white)),
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value as String?;
                  });
                },
              ),
            ),
            Flexible(
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Female', style: TextStyle(color: Colors.white)),
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value as String?;
                  });
                },
              ),
            ),
            Flexible(
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Other', style: TextStyle(color: Colors.white)),
                value: 'Other',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value as String?;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
