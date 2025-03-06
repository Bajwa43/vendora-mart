import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/features/auth/screens/loginScreen.dart';
import 'package:vendoora_mart/features/user/home/controller/home_controller.dart';
import 'package:vendoora_mart/features/user/home/screens/widgets/ads_scroller_widget.dart';
import 'package:vendoora_mart/features/user/home/screens/widgets/product_list_widget.dart';
import 'package:vendoora_mart/features/user/home/screens/widgets/search_widget.dart';
import 'package:vendoora_mart/features/user/profile/screen/profile_screen.dart';
import 'package:vendoora_mart/helper/firebase_helper/firebase_helper.dart';
import 'package:vendoora_mart/helper/helper_functions.dart';
import 'package:vendoora_mart/services/auth_service.dart';
import 'package:vendoora_mart/utiles/constants/colors.dart';
import 'package:vendoora_mart/utiles/constants/sizes.dart';
import 'package:vendoora_mart/utiles/constants/text_string.dart';

import 'widgets/profile_widget.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late TextEditingController searchController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    List<Widget> homeScreens = [
      SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: TSizes.padOfScreen, right: TSizes.padOfScreen),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileWidget(),
                  SearchInput(
                      textController: searchController, hintText: 'Search'),
                  AdsCrouselSliderWidget(),
                  ProductListWidget(lableName: TTextString.accessoriesCategory),
                  ProductListWidget(lableName: TTextString.clotheCategory),
                  ProductListWidget(lableName: TTextString.footwearCategory),
                ]),
          ),
        ),
      ),
      const Center(
          child: Text('Explore Screen', style: TextStyle(fontSize: 24))),
      const Center(
          child: Text('Carted Screen', style: TextStyle(fontSize: 24))),
      ProfileScreen(),
    ];
    return Scaffold(
      body: Obx(
        () => Center(
          child: homeScreens[homeController.currentIndexOfBottomAppBar
              .value], // Show screen based on the selected index
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            selectedItemColor:
                TColors.IconColor, // Highlighted color for active tab
            unselectedItemColor: Colors.white, //
            currentIndex: homeController.currentIndexOfBottomAppBar.value,
            onTap: (index) {
              homeController.currentIndexOfBottomAppBar.value =
                  index; // Update the current index
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                  backgroundColor: Color(0xFF9E9E9E)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_travel_rounded), label: 'cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'profile')
            ]),
      ),
    );
  }
}
