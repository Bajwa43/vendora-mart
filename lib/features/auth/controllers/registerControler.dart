import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendoora_mart/features/auth/domain/models/user_model.dart';
import 'package:vendoora_mart/helper/enum.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/services/auth_service.dart';
import 'package:vendoora_mart/utiles/constants/text_string.dart';

class RegisterController extends GetxController {
  Rx<File?> profileImage = Rx<File?>(null);
  Rx<File?> vendorImage = Rx<File?>(null);
  Rx<File?> vendorLogo = Rx<File?>(null);

  Future<void> imagePicker(BuildContext context, String imageType) async {
    print('object');
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      // final XFile? pickedFile = await picker.pickImage(
      // source: ImageSource.gallery,\
      //   maxWidth: 1080,
      //   maxHeight: 1080,
      //   imageQuality: 80,
      // );

      if (pickedFile != null) {
        switch (imageType) {
          case TTextString.profileImage:
            profileImage.value = File(pickedFile.path);

            break;
          case TTextString.vendorShopImage:
            vendorImage.value = File(pickedFile.path);

            break;
          case TTextString.vendorShopLogo:
            vendorLogo.value = File(pickedFile.path);

            break;
          default:
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  void registerUser({
    required BuildContext context,
    required TextEditingController fullnameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController phoneController,
    required TextEditingController businessNameController,
    required TextEditingController addressController,
    required TextEditingController cityController,
    required TextEditingController gstNumberController,
    required GlobalKey<FormState> formKey,
    required bool isVendor,
    required String? selectedTax, // Optional for vendors
  }) async {
    if (formKey.currentState!.validate()) {
      UserType userType = isVendor ? UserType.vendor : UserType.customer;

      UserModel user = UserModel(
          imageUrl: !isVendor
              ? profileImage.value!.path
              : '', // Handle image upload if needed
          fullName: isVendor ? null : fullnameController.text,
          email: emailController.text,
          password: passwordController.text,
          phone: phoneController.text,
          business: isVendor ? businessNameController.text : null,
          address: addressController.text,
          city: cityController.text,
          gstNumber: isVendor ? gstNumberController.text : null,
          textRegistered: isVendor ? selectedTax : null,
          userType: userType.value,
          approved: isVendor ? false : null,
          shopImageUrl: isVendor ? vendorImage.value!.path : '',
          userId: isVendor ? vendorLogo.value!.path : '');

      String? userCredentual = await AuthService.registerUserWithFirebaseAuth(
        context,
        emailController,
        fullnameController,
        phoneController,
        passwordController,
        user,
      );

      // String imageUrl = '';
      if (!isVendor) {
        if (profileImage.value != null) {
          await AuthService.uploadImageToStorage(
              profileImage.value, userCredentual, TTextString.profileImage);
        } else {
          if (vendorImage.value != null) {
            await AuthService.uploadImageToStorage(profileImage.value,
                userCredentual, TTextString.vendorShopImage);
            await AuthService.uploadImageToStorage(
                profileImage.value, userCredentual, TTextString.vendorShopLogo);
          }
        }

        // Clear form fields after registration
        fullnameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
      }
    }
  }
}
