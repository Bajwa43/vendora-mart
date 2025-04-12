import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoora_mart/features/auth/auth_wraper.dart';
import 'package:vendoora_mart/features/vendor/controller/product_controller.dart';
import 'package:vendoora_mart/features/vendor/domain/models/product_model.dart';
import 'package:uuid/uuid.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/services/auth_service.dart';
import 'package:vendoora_mart/utiles/constants/text_string.dart';

class UploadDataWidget extends StatelessWidget {
  const UploadDataWidget({super.key});

  Future uploadAllData(BuildContext context) async {
    String? validationMessage = ProductController.validateInputs();
    if (validationMessage != null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationMessage)),
      );
      return;
    }

    String productId = const Uuid().v4(); // Generate unique ID for the product

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
          ),
        ),
      );

      var venderId = FirebaseAuth.instance.currentUser!.uid;

      ProductModel productData = ProductModel(
        // images: ProductController.images,
        images: ProductController.images,
        venderUid: venderId,
        productUid: productId,
        publish: false,
        productName: ProductController.productNameController.text,
        price: ProductController.priceController.text,
        fashionCategory: ProductController.selectedFashionCategory,
        gender: ProductController.selectedGender,
        fashionItem: ProductController.selectedFashionItem,
        keyFeatures: ProductController.keyFeaturesController.text,
        description: ProductController.descriptionController.text,
        sizes: ProductController.selectedSizeList.cast<String>(),
      );

      // Upload product to Firestore
      await HelperFirebase.productInstance
          .doc(productId)
          .set(productData.toMap())
          .then(
        (value) {
          HelperFunctions.popBack(context: context);
          HelperFunctions.showToast('Product uploaded successfully');

          ProductController.productNameController.text = '';
          ProductController.priceController.text = '';
          ProductController.descriptionController.text = '';
          ProductController.keyFeaturesController.text = '';

          // ProductController.selectedFashionCategory = '';
          // ProductController.selectedFashionItem = '';
          // ProductController.selectedGender = '';
          ProductController.selectedSizeList = [];
        },
      );

      for (var i = 0; i < ProductController.images.length; i++) {
        await AuthService.uploadImageToStorage(
            File(ProductController.images[i]),
            '${FirebaseAuth.instance.currentUser!.uid}/${i + 1}',
            TTextString.productImages);
      }

      print('Product uploaded successfully');
    } catch (e) {
      print('Error uploading product: $e');
      throw Exception('Failed to upload product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () => uploadAllData(context),
          child: Text(
            'Upload',
            style: TextStyle(color: Colors.red),
          )),
    );
  }
}
