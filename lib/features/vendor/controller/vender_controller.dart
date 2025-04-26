import 'package:get/get.dart';
import 'package:vendoora_mart/features/user/home/domain/model/order/order_conform_model.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';

class VenderController extends GetxController {
  Stream<List<OrderConformModel>> getVenderOrders() {
    return HelperFirebase.orderConformInstance.doc();
  }
}
