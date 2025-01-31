import 'package:flutter/material.dart';
import 'package:vendoora_mart/features/vendor/add_Product/vender_add_item_screen.dart';
import 'package:vendoora_mart/features/vendor/widgets/icon_text_btn.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/services/auth_service.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconTextBtn(
                text: 'Fashion',
                onTap: () => HelperFunctions.navigateToScreen(
                    context: context, screen: VendorDashboardScreen())),
            IconTextBtn(
              text: 'Cars',
            ),
            IconTextBtn(
              text: 'Real Estate',
            ),
            ElevatedButton(
                onPressed: () {
                  AuthService.logOut(context);
                },
                child: Text('Signout'))
          ],
        ),
      ),
    );
  }
}
