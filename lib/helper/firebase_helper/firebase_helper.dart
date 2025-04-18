import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:vendoora_mart/features/user/home/controller/home_controller.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';

class HelperFirebase {
  static HomeController homeController = Get.find();
  // static var categroyTypeFirestoreInstance =
  //     FirebaseFirestore.instance.collection('CategoryType');
  static var storageInstance = FirebaseStorage.instance;

  // static var tasksFirestoreInstance =
  //     FirebaseFirestore.instance.collection('Tasks');

  // static

  static var userInstance =
      FirebaseFirestore.instance.collection('VenderUsers');

  static var addToCartInstance = HelperFirebase.userInstance
      .doc(homeController.firebaseUser.value?.uid.toString())
      // .doc()
      .collection('Carted');
  static var productInstance =
      FirebaseFirestore.instance.collection('VenderProducts');

  static var productInstanceWhichAlreadyPublished =
      HelperFirebase.productInstance.where('publish', isEqualTo: true);

  static publishProduct(
      BuildContext context, String productUid, bool currentStatus) async {
    try {
      HelperFunctions.showBottomSheet(context);
      await productInstance.doc(productUid).update({'publish': !currentStatus});
      HelperFunctions.popBack(context: context);
      // HelperFunctions.popBack(context: context);
      String action = currentStatus ? 'Unpublished' : 'Published';
      HelperFunctions.showToast('Product $action successfully!');
    } catch (e) {
      HelperFunctions.showToast(e.toString());
    }
  }

  static updateItem(
      BuildContext context, String productUid, var productData) async {
    try {
      HelperFunctions.showBottomSheet(context);
      await productInstance.doc(productUid).update(productData);
      HelperFunctions.popBack(context: context);
      HelperFunctions.showToast('Udated');
    } catch (e) {
      HelperFunctions.showToast(e.toString());
    }
  }

  static deleteFromProduct(BuildContext context, String id) async {
    try {
      HelperFunctions.showBottomSheet(context);
      await productInstance.doc(id).delete();
      HelperFunctions.popBack(context: context);
      HelperFunctions.showToast('Product Delete successfully!');
    } catch (e) {
      HelperFunctions.showToast(e.toString());
    }
  }

  // user({required String userId}) {
  //   return FirebaseFirestore.instance
  //       .collection('user')
  //       .doc()
  //       .collection(userId)
  //       .doc()
  //       .collection('tasks');
  // }
}
