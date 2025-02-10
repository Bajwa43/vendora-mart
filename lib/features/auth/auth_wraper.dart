import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoora_mart/features/auth/screens/loginScreen.dart';
import 'package:vendoora_mart/features/user/home/screens/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.amber,
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        var user = snapshot.data;

        if (user != null) {
          return const UserHomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
