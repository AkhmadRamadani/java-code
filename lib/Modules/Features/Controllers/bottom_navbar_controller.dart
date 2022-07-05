import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Features/Views/UI/beranda_view.dart';

class BottomNavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> pages = <Widget>[
    BerandaView(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  void onItemTapped(int index) {
    selectedIndex = index.obs;
    update();
  }
}
