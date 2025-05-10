// lib/features/vendor/home/controller/vendor_order_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/features/user/home/domain/model/order/order_conform_model.dart';
import 'package:vendoora_mart/features/user/home/domain/model/order/order_item_model.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';

/// A lightweight preview model for vendor orders
class VendorOrderPreview {
  final String orderID;
  final String orderStatus; // e.g. "Pending", "Shipped", etc.
  final bool orderSatus; // user‑confirmed → delivered
  final DateTime orderDate;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String buyerName;
  final String buyerEmail;

  VendorOrderPreview({
    required this.orderID,
    required this.orderStatus,
    required this.orderSatus,
    required this.orderDate,
    required this.items,
    required this.totalAmount,
    required this.buyerName,
    required this.buyerEmail,
  });
}

class VendorOrderController extends GetxController {
  /// The list of orders relevant to *this* vendor
  final RxList<VendorOrderPreview> _orders = <VendorOrderPreview>[].obs;
  List<VendorOrderPreview> get orders => _orders;

  late final String vendorId;

  @override
  void onInit() {
    super.onInit();
    vendorId = FirebaseAuth.instance.currentUser!.uid;
    _bindOrdersStream();
  }

  void _bindOrdersStream() {
    FirebaseFirestore.instance
        .collection(
            'OrderConform') // matches HelperFirebase.orderConformInstance
        .orderBy('orderDate', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final futures = snapshot.docs.map((doc) async {
        final raw = doc.data();
        final model = OrderConformModel.fromMap(raw);

        // 1️⃣ Extract the slice for this vendor
        final vendorSlices =
            model.orderItemVendor.where((v) => v.venderID == vendorId).toList();
        if (vendorSlices.isEmpty) return null;
        final mySlice = vendorSlices.first;

        double totalAmount = 0;

        for (var i = 0; i < mySlice.productList.length; i++) {
          totalAmount += await HelperFirebase.productInstance
              .doc(mySlice.productList[i].productID)
              .get()
              .then((value) {
            var data = value.data() as Map<String, dynamic>;
            return int.parse(data['price']) * mySlice.productList[i].quantity;
          });
        }

        // 2️⃣ Fetch buyer info
        final userDoc =
            await HelperFirebase.userInstance.doc(model.userID).get();
        final userData = userDoc.data() as Map<String, dynamic>? ?? {};
        final buyerName = userData['fullName'] as String? ?? 'Unknown';
        final buyerEmail = userData['email'] as String? ?? '—';

        // 3️⃣ Build preview
        return VendorOrderPreview(
          orderID: model.orderID,
          orderStatus: mySlice.orderStatus, // vendor-side status string
          orderSatus: model.orderSatus, // user-confirmed boolean
          orderDate: model.orderDate.toDate(),
          items: mySlice.productList,
          totalAmount: totalAmount,
          buyerName: buyerName,
          buyerEmail: buyerEmail,
        );
      });

      final previews =
          (await Future.wait(futures)).whereType<VendorOrderPreview>().toList();
      return previews;
    }).listen((previews) {
      _orders.assignAll(previews);
    });
  }
}
