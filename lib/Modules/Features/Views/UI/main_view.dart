import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/bottom_navbar_controller.dart';

class MainView extends GetView<BottomNavbarController> {
  MainView({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavbarController>(
        init: BottomNavbarController(),
        builder: (value) {
          return Scaffold(
            extendBody: true,
            body: value.pages.elementAt(value.selectedIndex.value),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomNavigationBar(
                  backgroundColor: colorConst.bottomNavBarColor,
                  currentIndex: value.selectedIndex.value,
                  onTap: value.onItemTapped,
                  selectedItemColor: Colors.white,
                  selectedIconTheme: IconThemeData(color: Colors.white),
                  unselectedItemColor: colorConst.inactiveColor,
                  unselectedIconTheme:
                      IconThemeData(color: colorConst.inactiveColor),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "home".tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_outlined),
                      label: 'order'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_rounded),
                      label: 'profil'.tr,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
