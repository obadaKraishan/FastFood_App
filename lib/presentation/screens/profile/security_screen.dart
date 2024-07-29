import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
        backgroundColor: Color(0xFF1C2029),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () => _showChangePasswordDialog(context),
          ),
          ListTile(
            leading: Icon(Icons.fingerprint),
            title: Text('Enable Fingerprint/FaceID'),
            onTap: () => _enableBiometricAuthentication(context),
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Two-Factor Authentication'),
            onTap: () => _enableTwoFactorAuthentication(context),
          ),
        ],
      ),
      backgroundColor: Color(0xFF1C2029),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Enter new password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(hintText: 'Confirm new password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String newPassword = _passwordController.text.trim();
                  try {
                    await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
                    Fluttertoast.showToast(msg: 'Password updated successfully');
                    Navigator.pop(context);
                  } catch (e) {
                    if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
                      Fluttertoast.showToast(msg: 'Please re-authenticate and try again');
                    } else {
                      Fluttertoast.showToast(msg: 'Failed to update password: ${e.toString()}');
                    }
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _enableBiometricAuthentication(BuildContext context) async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isBiometricAvailable = await auth.isDeviceSupported();
      if (canCheckBiometrics && isBiometricAvailable) {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to enable biometric authentication',
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );
        if (authenticated) {
          Fluttertoast.showToast(msg: 'Biometric authentication enabled');
        } else {
          Fluttertoast.showToast(msg: 'Failed to authenticate');
        }
      } else {
        Fluttertoast.showToast(msg: 'Biometric authentication not available on this device');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  void _enableTwoFactorAuthentication(BuildContext context) {
    Fluttertoast.showToast(msg: 'Two-Factor Authentication feature coming soon');
  }
}
