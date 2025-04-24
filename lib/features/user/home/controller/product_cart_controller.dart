import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:vendoora_mart/features/auth/domain/models/user_model.dart';
import 'package:vendoora_mart/features/user/home/controller/home_controller.dart';
import 'package:vendoora_mart/features/user/home/domain/model/carted_model.dart';
import 'package:vendoora_mart/features/user/home/domain/model/order/order_conform_model.dart';
import 'package:vendoora_mart/features/user/home/domain/model/order/order_item_model.dart';
import 'package:vendoora_mart/features/user/home/screens/cart_list_page/screen/check_out_page.dart';
import 'package:vendoora_mart/features/user/home/screens/cart_list_page/screen/checkout_receipt.dart';
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

  HomeController hConroller = Get.find();

  UserModel? userObj;
  var uuid = Uuid();
  // return uuid.v4(); //

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

  void toggleCartAnimation() {
    if (topPosition.value == 0.0) {
      topPosition.value = -300.0; // Move out of the screen
    } else {
      topPosition.value = 0.0; // Move to its final position
    }
  }

  void orderCheckOutCompletion(BuildContext context) async {
    List<OrderItemModel> orderItems = cartProduct.map(
      (e) {
        String orderItemID = uuid.v1();
        return OrderItemModel(
            orderItemID: orderItemID,
            productID: e.productId,
            quantityOfProduct: e.noOfProduct);
      },
    ).toList();

    String userID = FirebaseAuth.instance.currentUser!.uid.toString();
    String orderID = uuid.v1();
    OrderConformModel orderConformModel = OrderConformModel(
        orderID: orderID,
        userID: userID,
        orderItem: orderItems,
        orderDate: Timestamp.now(),
        paymentMethod: hConroller.cashPayment.value ? 'Cash' : 'Debit Card',
        totalAmount: total.value);

    HelperFunctions.showBottomSheet(Get.context!);

    final cartedCollection = HelperFirebase.deleteCartedItemInstance;

    final snapshot = await cartedCollection.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
    hConroller.cashPayment.value = true;
    hConroller.debitCardPayment.value = false;

    HelperFirebase.orderConformInstance.doc(orderID).set(
          orderConformModel.toMap(),
        );

    HelperFunctions.popBack(context: context);

    HelperFunctions.showToast('Order Placed Successfully');
    HelperFunctions.navigateToScreen(
        context: context,
        screen: ReceiptScreen(
          order: orderConformModel,
        ));
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
