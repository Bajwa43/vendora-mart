import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:todo_app/Dialogs/dialog.dart';
// import 'package:todo_app/Dialogs/inform_dialog.dart';
// import 'package:todo_app/data/Constants/colors.dart';
// import 'package:todo_app/data/Constants/size.dart';
// import 'package:todo_app/data/helpers/firebase_helper/firebase_helper.dart';
// import 'package:todo_app/data/helpers/helper_functions.dart';
// import 'package:todo_app/models/HomeTaskModel/home_task_Model.dart';
// import 'package:todo_app/models/user_model.dart/user_model.dart';
// import 'package:todo_app/modules/home_module/home_screen.dart';
// import 'package:todo_app/services/auth_exception_handler.dart';
// import 'package:todo_app/widgets/txtWidget.dart';
import 'package:vendoora_mart/features/auth/domain/models/user_model.dart';
import 'package:vendoora_mart/features/user/home/screens/home_screen.dart';
import 'package:vendoora_mart/features/vendor/home/screens/vendor_home_Screen.dart';
import 'package:vendoora_mart/helper/enum.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/services/auth_exception_handler.dart';
// import '../features/auth/domain/models/vendor_model.dart';
import '../features/vendor/add_Product/vender_add_item_screen.dart';

class AuthService {
  static logOut(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => HelperFunctions.popBack(context: context));
  }

  // static late AuthStatus _status;
  //login with pass and email function

  // // FORGET PASSWORD
  // static Future forgetPasswordWithEmail(
  //     String email, BuildContext context) async {
  //   // FirebaseAuth.instance.confirmPasswordReset(code: code, newPassword: newPassword)
  //   await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
  //     (value) {
  //       showDialog(
  //           context: context,
  //           builder: (context) => Dialog(
  //                 child: InformDialogWidget(
  //                   heightOfDialog: 200.h,
  //                   trigarBtnName: 'Ok',
  //                   dialogTitle: 'Email Conformation!',
  //                   onPressed: () {
  //                     Get.back();
  //                     Get.back();
  //                   },
  //                   child: TextWidget(
  //                     padHori: 0,
  //                     padVerti: 0,
  //                     text: 'Message send your Email box! If it is Exist.',
  //                     textStyle: KAppTypoGraphy.dialogeText18Medium,
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   //
  //                 ),
  //               ));
  //     },
  //   );
  //   //  .then(
  //   // (value) {
  //   //   _status == AuthStatus.successful;
  //   //   // Get.to();
  //   // },
  //   // );
  // }

  // LOGIN
  static Future<void> loginUserWithEmailAndPassword(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      print('Enter in TRY BLOck ');
      // Show loading dialog
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (context) => const Center(
      //     child: CircularProgressIndicator.adaptive(
      //       valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
      //     ),
      //   ),
      // );

      // Authenticate user
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      // Fetch user data from Firestore

      QuerySnapshot snapshot = await HelperFirebase.userInstance
          .where('email', isEqualTo: emailController.text)
          .where('userType', isEqualTo: UserType.vendor.value)
          .get();

      print('After CHECK INSTANCE ');

      // Close loading dialog
      // Navigator.pop(context);

      print('After CHECK INSTANCE AND POP CIRCULAR');

      // Navigate based on user type
      if (snapshot.docs.isNotEmpty) {
        print('ENTER IN WITH VENDER INSTANCE ');

        // Vendor user
        HelperFunctions.navigateToScreen(
            context: context, screen: VendorHomeScreen());
      } else {
        print('✅ Navigating to UserHomeScreen');
        print('Snapshot empty, treating as customer.');

        await Future.delayed(
            Duration(milliseconds: 500)); // Small delay for UI updates

        await Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => UserHomeScreen()),
        );

        print('✅ Navigation should have occurred.');

        // Regular user

        // Navigator.pop(context);

        // HelperFunctions.navigateToScreen(
        //     context: context, screen: UserHomeScreen());

        // await Get.off(() => UserHomeScreen());
      }

      // Show success toast
      HelperFunctions.showToast(
          '${userCredential.user!.email} logged in successfully');
    } on FirebaseAuthException catch (e) {
      print('ENTER IN FIRST CATCH');

      // Close loading dialog
      Navigator.pop(context);

      // Handle authentication error
      AuthStatus status = AuthExceptionHandler.handleAuthException(e);
      String error = AuthExceptionHandler.generateErrorMessage(status);
      HelperFunctions.showToast(error);
    } catch (e) {
      // Close loading dialog for any unexpected errors
      // Navigator.pop(context);
      print('ENTER IN SECOND CATCH');

      HelperFunctions.showToast(
          'An unexpected error occurred. Please try again.');
      debugPrint('Error: $e');
    }
  }

  // static loginUserWithEmailAndPassword(
  //     BuildContext context, var emailController, var passwordController) async {
  //   try {
  //     showModalBottomSheet(
  //         context: context,
  //         isDismissible: false,
  //         scrollControlDisabledMaxHeightRatio: 10,
  //         sheetAnimationStyle: AnimationStyle(
  //           duration: const Duration(milliseconds: 600),
  //         ),
  //         constraints: BoxConstraints(
  //             maxHeight: MediaQuery.sizeOf(context).height,
  //             maxWidth: MediaQuery.sizeOf(context).width),
  //         builder: (context) => Scaffold(
  //               body: Center(
  //                 child: SizedBox(
  //                   height: MediaQuery.sizeOf(context).height * 1,
  //                   child: const Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       CircularProgressIndicator.adaptive(
  //                         valueColor:
  //                             AlwaysStoppedAnimation(Colors.amberAccent),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ));

  //     var user = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //             email: emailController.text, password: passwordController.text)
  //         .then(
  //       (value) {
  //         HelperFirebase.userInstance
  //             .where('userType', isEqualTo: UserType.vendor.value)
  //             .where('email',
  //                 isEqualTo: emailController.text) // Check for city = New York
  //             .get()
  //             .then((QuerySnapshot snapshot) {
  //           // Handle the vendors data
  //           HelperFunctions.navigateToScreen(
  //               context: context, screen: VendorHomeScreen());
  //         });

  //         HelperFunctions.navigateToScreen(
  //             context: context, screen: DashboardScreen());
  //       },
  //     );

  //     // Get.back();
  //     HelperFunctions.popBack(context: context);
  //     // Get.back();
  //     // Get.to(const HomeScreen());
  //     HelperFunctions.showToast('${user.user!.email} >> is Login sucessFuly');
  //     HelperFunctions.navigateToScreen(
  //         context: context, screen: DashboardScreen());
  //   } on FirebaseAuthException catch (e) {
  //     // Get.back();
  //     HelperFunctions.popBack(context: context);
  //     AuthStatus status = AuthExceptionHandler.handleAuthException(e);
  //     String error = AuthExceptionHandler.generateErrorMessage(status);
  //     HelperFunctions.showToast(error);
  //   }
  // }

//  REGISTER
  static registerUserWithFirebaseAuth(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController fullNameController,
      TextEditingController phoneController,
      TextEditingController passwordController,
      UserModel user) async {
    try {
      showModalBottomSheet(
          context: context,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height,
              maxWidth: MediaQuery.sizeOf(context).width),
          builder: (context) => const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
                      ),
                    ],
                  ),
                ),
              ));
      // Get.back();
      print("Full Name Before: ${fullNameController.text}");

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // UserModel userModel = UserModel(
      //     userId: userCredential.user!.uid,
      //     email: userCredential.user!.email.toString(),
      //     fullName: fullNameController.text.trim(),
      //     phone: phoneController.text.trim());

      user.userId = userCredential.user!.uid;

      // print("Full Name After: ${fullNameController.text}");
      await HelperFirebase.userInstance
          .doc(userCredential.user!.uid)
          .set(user.toMap());

      // // .collection('Tasks');
      // // .doc();
      // // .set();
      // Get.back();
      HelperFunctions.popBack(context: context);

      // Get.back();
      // HelperFunctions.popBack(context: context);

      HelperFunctions.showToast(
          '${userCredential.user!.email} >> is Registerd');
      // print("Full Name Last: ${fullNameController.text}");
    } catch (e) {
      fullNameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      // Get.back();
      HelperFunctions.popBack(context: context);
      HelperFunctions.showToast(e.toString());
      print('>>>>>>>>>>>>>>>>>>> ${e.toString()}');
      HelperFunctions.showToast('Issue');
    }
  }
}
