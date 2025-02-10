import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendoora_mart/utiles/constants/colors.dart';
import 'package:vendoora_mart/utiles/constants/sizes.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.widthOfContainer,
      // required this.heightOfContainer,
      required this.textOfBtn,
      this.onTap});
  final double widthOfContainer;
  // final double heightOfContainer;
  final String textOfBtn;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.h,
        width: widthOfContainer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: TColors.IconColor,
        ),
        child: Center(
            child: Text(
          textOfBtn.toString(),
          style: TextStyle(fontSize: TSizes.productLabelL),
        )),
      ),
    );
  }
}
