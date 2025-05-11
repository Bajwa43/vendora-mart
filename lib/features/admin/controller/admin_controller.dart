import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vendoora_mart/features/admin/admin_dashboard/screens/dashboard/dashboard.dart';
import 'package:vendoora_mart/features/admin/admin_dashboard/screens/order/order.dart';
import 'package:vendoora_mart/features/admin/admin_dashboard/screens/product/product.dart';
import 'package:vendoora_mart/features/admin/admin_dashboard/screens/vendor/vendor.dart';
import 'package:vendoora_mart/features/auth/domain/models/user_model.dart';
import 'package:vendoora_mart/features/user/home/domain/model/order/order_conform_model.dart';
import 'package:vendoora_mart/features/vendor/domain/models/product_model.dart';
import 'package:vendoora_mart/helper/enum.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/services/auth_service.dart';
import 'package:vendoora_mart/utiles/constants/text_string.dart';

class AdminNavController extends GetxController {
  var currentIndex = 0.obs;
  final Rxn<UserModel> adminUser = Rxn<UserModel>();
  RxString imageUrl = ''.obs;
  RxBool isSidebarOpen = false.obs;
  RxList<OrderConformModel> _listOfOrderProducts = <OrderConformModel>[].obs;
  List<OrderConformModel> get listOfOrderProducts => _listOfOrderProducts;
  RxList<ProductModel> _listOfProducts = <ProductModel>[].obs;
  List<ProductModel> get listOfProducts => _listOfProducts;
  RxList<UserModel> _listOfVendors = <UserModel>[].obs;
  List<UserModel> get listOfVendors => _listOfVendors;

  @override
  void onInit() {
    super.onInit();
    debugPrint('AdminNavController onInit called');

    _listOfOrderProducts.bindStream(getOrderProducts());
    _listOfProducts.bindStream(getProducts());
    _listOfVendors.bindStream(getVendors());

    getUser();
    // _loadImage();
  }

  // @override
  // void onClose() {
  //   _listOfOrderProducts.close();
  //   _listOfProducts.close();
  //   super.onClose();
  // }

  Stream<List<ProductModel>> getProducts() {
    return HelperFirebase.productInstanceWhichAlreadyPublished
        .snapshots()
        .map((event) {
      return event.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    });
  }

  Stream<List<UserModel>> getVendors() {
    return HelperFirebase.userInstance
        .where('userType', isEqualTo: UserType.vendor.value)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => UserModel.fromMap(e.data())).toList();
    });
  }

  Stream<List<OrderConformModel>> getOrderProducts() {
    print('getOrderProducts');
    return HelperFirebase.orderConformInstance
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((event) {
      print('getOrderProducts event: ${event.docs.length}');
      var list;

      list =
          event.docs.map((e) => OrderConformModel.fromMap(e.data())).toList();
      print('LIST>> ${list.length}');
      return list;
    });
  }

  // Future<void> _loadImage() async {
  //   AdminNavController contro = Get.find();
  //   String url = await AuthService.getImageUrl(
  //       '${TTextString.profileImage}/${FirebaseAuth.instance.currentUser!.uid}.jpg');
  //   contro.imageUrl.value = url;
  // }

  void getUser() async {
    try {
      final currentEmail = FirebaseAuth.instance.currentUser?.uid;
      if (currentEmail == null)
        () {
          print("No user is currently logged in.");
          return;
        };

      final snapshot = await HelperFirebase.userInstance
          .where('userId', isEqualTo: currentEmail)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs[0].data();
        adminUser.value = UserModel(
          fullName: data['name'],
          email: data['email'],
          phone: data['phone'],
          userType: data['userType'],
          imageUrl: data['imageUrl'],
        );
      } else {
        print("Admin user not found in Firestore.");
      }
    } catch (e) {
      print("Error fetching admin user: $e");
    }
  }

  final appBarTitles = [
    'Dashboard',
    'Orders',
    'Vendors',
    'Products',
  ];
  final pages = [
    AdminDashboardPage(),
    AdminOrdersPage(),
    AdminVendorsPage(),
    AdminProductsPage()
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
