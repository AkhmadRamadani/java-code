import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Features/Views/UI/beranda_view.dart';
import 'package:javacode/Modules/Features/Views/UI/history_pesanan_view.dart';
import 'package:javacode/Modules/Features/Views/UI/profile_view.dart';

class BottomNavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> pages = <Widget>[
    BerandaView(),
    HistoryPesananView(),
    ProfileView(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index.obs;
    update();
  }
}
