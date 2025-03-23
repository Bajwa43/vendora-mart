import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoora_mart/features/auth/screens/loginScreen.dart';
import 'package:vendoora_mart/features/user/home/screens/home_screen.dart';
import 'package:vendoora_mart/features/vendor/home/screens/vendor_home_Screen.dart';
import 'package:vendoora_mart/helper/enum.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/utiles/constants/colors.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<QuerySnapshot> checkUser(String email) async {
    QuerySnapshot snapshot = await HelperFirebase.userInstance
        .where('email', isEqualTo: email)
        .where('userType', isEqualTo: UserType.vendor.value)
        .get();

    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: TColors.accent,
            body: const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          );
        }
        var user = snapshot.data;

        if (user != null) {
          return FutureBuilder(
            future: checkUser(user.email.toString()),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: TColors.accent,
                  body: const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                );
              }

              if (snapShot.hasError) {
                return Scaffold(
                  body: Center(child: Text("Error: ${snapShot.error}")),
                );
              }

              if (snapShot.hasData && snapShot.data!.docs.isNotEmpty) {
                return const VendorHomeScreen();
              } else {
                return const UserHomeScreen();
              }
            },
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
