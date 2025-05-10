import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/app.dart';
import 'package:vendoora_mart/firebase_options.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
// void main() {
//   runApp(GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: AnimatedAdminDashboard(),
//   ));
// }




