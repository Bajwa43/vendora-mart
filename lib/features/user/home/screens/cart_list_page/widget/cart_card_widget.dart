import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendoora_mart/common/iconbtn.dart';
import 'package:vendoora_mart/features/user/home/domain/model/carted_model.dart';
import 'package:vendoora_mart/utiles/constants/colors.dart';
import 'package:vendoora_mart/utiles/constants/image_string.dart';
import 'package:vendoora_mart/utiles/constants/sizes.dart';
import 'package:vendoora_mart/utiles/constants/txt_theme.dart';

class CartCardWidget extends StatelessWidget {
  const CartCardWidget(
      {super.key,
      required this.model,
      this.onDelete,
      this.onMinuse,
      this.onAdd});
  final CartedModel model;
  final void Function()? onDelete;
  final void Function()? onMinuse;
  final void Function()? onAdd;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 343.w,
        height: 110.h,
        color: TColors.darkContainer,
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Stack(children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 126.w,
                    height: 99.h,
                    child: Image.network(
                      model.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                // TEXT >>>>>>>>>>>>>>>>>>>>>>>
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(model.productName, style: TTextStyle.labelTextStyle),
                      Text(
                        model.categoryType,
                        style: TTextStyle.brandTextStyle,
                      ),
                      Text(
                        '\$${model.price}',
                        style: TTextStyle.priceTextStyle,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: FittedBox(
                    child: InkWell(
                      onTap: onDelete,
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset(
                              TImageString.deleteBasket,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Row(
                children: [
                  IconBtnWidget(
                    onTap: onMinuse,
                    icon: Icons.remove,
                    iconSize: 14.sp,
                    width: 28.w,
                    height: 28,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      model.noOfProduct,
                      style: TTextStyle.labelTextStyle,
                    ),
                  ),
                  IconBtnWidget(
                    onTap: onAdd,
                    iconSize: 14.sp,
                    width: 28.w,
                    height: 28,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
