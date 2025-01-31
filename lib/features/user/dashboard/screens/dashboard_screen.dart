import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('User Dashboard'),
              ElevatedButton(
                  onPressed: () async {
                    AuthService.logOut(context);
                    // HelperFunctions.popBack(context: context);
                  },
                  child: Text('Logout'))
            ]),
      ),
    );
  }
}
