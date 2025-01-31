import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendoora_mart/features/auth/screens/loginScreen.dart';
import 'package:vendoora_mart/features/auth/screens/registration.dart';
import 'package:vendoora_mart/features/vendor/add_Product/vender_add_item_screen.dart';
import 'package:vendoora_mart/features/vendor/home/screens/vendor_home_Screen.dart';
import 'package:vendoora_mart/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
        child: MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));
  }
}
