import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/common/Btn.dart';
import 'package:vendoora_mart/common/top_back_and_label_appbar.dart';
import 'package:vendoora_mart/features/user/home/controller/product_cart_controller.dart';
import 'package:vendoora_mart/features/user/home/screens/cart_list_page/widget/calculated_total_widget.dart';
import 'package:vendoora_mart/features/user/home/screens/cart_list_page/widget/check-out_widget.dart';
import 'package:vendoora_mart/features/user/home/screens/cart_list_page/widget/payment_container.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/utiles/constants/image_string.dart';
import 'package:vendoora_mart/utiles/constants/sizes.dart';
import 'package:vendoora_mart/utiles/constants/txt_theme.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    final ProductCartController controller = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopAppBarWidget(label: 'Check Out'),
            CheckOutWidget(
                onTap: () {
                  HelperFunctions.showToast('hy');
                },
                colorLogoContainer: Color.fromRGBO(240, 241, 242, 0.098),
                title: '325 15th Eighth Avenue, NewYork',
                imageUrl: TImageString.adressLogo.toString()),
            CheckOutWidget(
                colorLogoContainer: Color.fromRGBO(99, 205, 255, 0.1),
                title: '6:00 pm, Wednesday 20',
                imageUrl: TImageString.adressLogo.toString()),
            Spacer(),
            CalculateTotalWidget(
                isLabelShow: true,
                totalItems: controller.cartProduct.length.toString(),
                subTotal: controller.subTotal.value.toString(),
                descount: controller.discount.value.toString(),
                deliveryCharges: controller.deliveryCharges.value.toString(),
                total: controller.total.value.toString()),
            OrderPaymentWidget(),
            Padding(
              padding: EdgeInsets.all(10),
              child: ButtonWidget(
                  widthOfContainer: TSizes.fullContainerW,
                  textOfBtn: 'Check Out'),
            )
          ],
        ),
      ),
    );
  }
}
