import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../views/home_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  final AuthService _authService = AuthService();

  Future<void> _signInWithGoogle() async {
    try {
      // Call the AuthService method
      await _authService.signInWithGoogle();

      // If sign-in is successful, navigate to the HomeScreen (or whichever screen you want)

    } catch (e) {
      // If sign-in fails or is canceled, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login or Register'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _signInWithGoogle,
          icon: const Icon(
            Icons.login, // Not the official G logo, but a placeholder icon
            size: 20,
          ),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,    // Button background color
            foregroundColor: Colors.black87,  // Text & Icon color
            minimumSize: const Size(200, 50), // Set a custom minimum size
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

