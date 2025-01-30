import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_or_register.dart';
import '../views/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Stream that emits the current user if logged in, or null if not
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If snapshot.connectionState is waiting, you can show a loading spinner
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If the stream has a user, they're logged in
        if (snapshot.hasData) {
          // The user is signed in, show home screen
          return const HomeScreen();
        } else {
          // The user is NOT signed in, show login
          return const LoginOrRegister();
        }
      },
    );
  }
}
