import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendoora_mart/utiles/constants/image_string.dart';
import 'package:vendoora_mart/utiles/constants/sizes.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 64.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.sp),
            child: Container(
              width: TSizes.profilePictureW,
              height: TSizes.profilePictureH,
              child: Image.asset(TImageString.myImage),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'hello!',
                style: TextStyle(fontSize: TSizes.headingSmallS),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: TextStyle(fontSize: TSizes.headingMediumS),
              ),
            ],
          ),
          SizedBox(
              width: TSizes.profileIconContainer,
              height: TSizes.iconContainerH,
              child: Icon(
                Icons.add_alert_sharp,
                size: TSizes.profileIcon,
              ))
        ],
      ),
    );
  }
}
