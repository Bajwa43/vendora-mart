import 'package:get/get.dart';

class ProductCartController extends GetxController {
  var topPosition = (-300.0).obs; // Start outside the screen
  var leftPosition = 0.0.obs; // Keep it centered horizontally

  @override
  void onInit() {
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
}
