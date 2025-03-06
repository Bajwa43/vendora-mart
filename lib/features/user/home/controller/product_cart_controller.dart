import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/features/auth/domain/models/user_model.dart';
import 'package:vendoora_mart/features/user/home/domain/model/carted_model.dart';
import 'package:vendoora_mart/features/user/home/screens/cart_list_page/screen/check_out_page.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';

class ProductCartController extends GetxController {
  var topPosition = (-300.0).obs; // Start outside the screen
  var leftPosition = 0.0.obs; // Keep it centered horizontally
  RxList<CartedModel> _cartProduct = <CartedModel>[].obs;
  List<CartedModel> get cartProduct => _cartProduct;
  RxDouble subTotal = 0.0.obs;
  RxDouble discount = 4.0.obs;
  RxDouble deliveryCharges = 2.0.obs;
  RxDouble total = 0.0.obs;

  UserModel? userObj;

  // RxBool isCheckOut = true.obs;

  @override
  void onInit() {
    _cartProduct.bindStream(getCartProducts());
    super.onInit();
    Future.delayed(Duration(milliseconds: 200), () {
      topPosition.value = 0.0; // Move to its final position
    });
    Future.delayed(
      Duration(milliseconds: 300),
      () {
        topPosition = (-300.0).obs;
      },
    );
  }

  void calculateSubtotal() {
    double tempSubTotal = 0;
    for (var i = 0; i < cartProduct.length; i++) {
      tempSubTotal += double.parse(cartProduct[i].price) *
          double.parse(cartProduct[i].noOfProduct);
    }
    subTotal.value = tempSubTotal;
    total.value = (subTotal.value - discount.value) + deliveryCharges.value;
  }

  Stream<List<CartedModel>> getCartProducts() {
    return HelperFirebase.addToCartInstance.snapshots().map(
      (event) {
        return event.docs.map((e) => CartedModel.fromMap(e.data())).toList();
      },
    );
  }

  deleteCartProduct(String productId, BuildContext context) async {
    try {
      HelperFunctions.showBottomSheet(context);
      await HelperFirebase.addToCartInstance.doc(productId).delete();
      Get.back();
      subTotal = 0.0.obs;
      HelperFunctions.showToast('Deleted Successfully');
      calculateSubtotal();
    } catch (e) {
      HelperFunctions.showToast(e.toString());
    }
  }

  onIncremntProduct(String cartedId, int value) async {
    try {
      int incrementValue = value + 1;
      await HelperFirebase.addToCartInstance
          .doc(cartedId)
          .update({'noOfProduct': incrementValue.toString()});
      calculateSubtotal();
    } catch (e) {
      HelperFunctions.showToast(e.toString());
    }
  }

  onDecrementProduct(String cartedId, int value, BuildContext context) async {
    try {
      if (value > 1) {
        int incrementValue = value - 1;
        await HelperFirebase.addToCartInstance
            .doc(cartedId)
            .update({'noOfProduct': incrementValue.toString()});
        calculateSubtotal();
      } else {
        deleteCartProduct(cartedId, context);
      }
    } catch (e) {
      HelperFunctions.showToast(e.toString());
    }
  }

  onCheckOutBtn(BuildContext context) {
    HelperFunctions.navigateToScreen(context: context, screen: CheckOutPage());
  }

  getUserProfile() async {
    var auth = FirebaseAuth.instance;
    var uid = auth.currentUser!.uid.toString();
    var user = await HelperFirebase.userInstance.doc(uid).get();
    userObj = UserModel.fromMap(user.data()!);
  }
}
