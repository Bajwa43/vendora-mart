import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/features/user/home/domain/model/carted_model.dart';
import 'package:vendoora_mart/features/user/home/domain/model/wishlist_model.dart';
import 'package:vendoora_mart/features/user/home/screens/cart_list_page/cart_list_page.dart';
import 'package:vendoora_mart/features/user/home/screens/home_screen.dart';
import 'package:vendoora_mart/features/vendor/domain/models/product_model.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/utiles/constants/image_string.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final uuid = const Uuid();
  RxList<ProductModel> _listOfProducts = <ProductModel>[].obs;
  List<ProductModel> get listOfProducts => _listOfProducts;
  RxInt currentIndexOfBottomAppBar = 0.obs;

  Rx<User?> firebaseUser = Rx<User?>(FirebaseAuth.instance.currentUser);
  RxMap<String, bool> favoriteProducts = <String, bool>{}.obs;

  RxString selectedSize = ''.obs;

  void selectSize(String size) {
    selectedSize.value = size;
  }

  @override
  void onInit() {
    super.onInit();
    _listOfProducts.bindStream(getProducts());
    loadFavorites();
  }

  void addToCart(BuildContext context, ProductModel product) async {
    String docId = uuid.v4(); // Generate a unique ID
    CartedModel cartedModel = CartedModel(
      cartedId: docId,
      productName: product.productName.toString(),
      price: product.price.toString(),
      size: selectedSize.value,
      noOfProduct: '1',
      image: product.images.first.toString(),
      categoryType: product.fashionCategory.toString(),
    );
    try {
      HelperFunctions.showBottomSheet(context);
      await HelperFirebase.addToCartInstance
          .doc(docId)
          .set(cartedModel.toMap());
      Get.back();
      selectedSize = "".obs;
      HelperFunctions.navigateToScreen(
          context: context, screen: CartListPage());
    } catch (e) {
      HelperFunctions.showToast(e.toString());
    }
  }

  /// 🛒 **Load User's Favorites from Firestore**
  void loadFavorites() async {
    if (firebaseUser.value == null) return;

    var snapshot = await HelperFirebase.userInstance
        .doc(firebaseUser.value!.uid)
        .collection('wishlist')
        .get();

    for (var doc in snapshot.docs) {
      favoriteProducts[doc.id] =
          true; // setting the value (true) in Key (doc.id)
    }
    update(); // Refresh UI
  }

  /// ❤️ **Toggle Favorite Status**
  Future<void> onToggalFavt(String productId) async {
    if (firebaseUser.value == null) return;

    final wishlistRef = HelperFirebase.userInstance
        .doc(firebaseUser.value!.uid)
        .collection('wishlist')
        .doc(productId);

    if (favoriteProducts.containsKey(productId)) {
      favoriteProducts.remove(productId);
      await wishlistRef.delete(); // Remove from Firestore
    } else {
      favoriteProducts[productId] = true;
      await wishlistRef.set(
          WishlistModel(productId: productId, addedAt: Timestamp.now())
              .toMap());
    }

    update(); // Refresh UI
  }

  /// 📦 **Get List of Products**
  Stream<List<ProductModel>> getProducts() {
    return HelperFirebase.productInstance.snapshots().map((event) {
      return event.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    });
  }

  static List<Widget> adsList = [
    Container(
      color: Colors.red,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(child: Text("First index")),
        Image.asset(TImageString.greyShoeImage)
      ]),
    ),
    Container(
      color: Colors.blue,
      child: Row(children: [
        Center(child: Text("Second index")),
        Image.asset(TImageString.greyShoeImage)
      ]),
    ),
    Container(
      color: Colors.green,
      child: Row(children: [
        Center(child: Text("Third index")),
        Image.asset(TImageString.greyShoeImage)
      ]),
    ),
  ];
}
