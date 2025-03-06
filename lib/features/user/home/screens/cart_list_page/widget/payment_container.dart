import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendoora_mart/utiles/constants/colors.dart';
import 'package:vendoora_mart/utiles/constants/image_string.dart';
import 'package:vendoora_mart/utiles/constants/sizes.dart';
import 'package:vendoora_mart/utiles/constants/txt_theme.dart';

class OrderPaymentWidget extends StatelessWidget {
  const OrderPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: TSizes.fullContainerW,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose payment method',
            style: TTextStyle.tableHeader,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(TImageString.paypalLogo),
              Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'PayPal',
                    style: TTextStyle.OrderPaymentTextStyle,
                  )),
              const Spacer(),
              Checkbox(
                  side: BorderSide(color: TColors.buttonPrimory, width: 2),
                  shape: CircleBorder(),
                  value: false,
                  onChanged: (val) {})
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(TImageString.creditCardLogo),
              Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Credit Card',
                    style: TTextStyle.OrderPaymentTextStyle,
                  )),
              const Spacer(),
              Checkbox(
                  side: BorderSide(color: TColors.buttonPrimory, width: 2),
                  shape: CircleBorder(),
                  value: false,
                  onChanged: (val) {})
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(TImageString.coinLogo),
              Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Cash',
                    style: TTextStyle.OrderPaymentTextStyle,
                  )),
              const Spacer(),
              Checkbox(
                  side: BorderSide(color: TColors.buttonPrimory, width: 2),
                  shape: CircleBorder(),
                  value: false,
                  onChanged: (val) {})
            ],
          ),
        ],
      ),
    );
  }
}
