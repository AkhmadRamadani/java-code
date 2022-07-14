import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Features/Views/UI/find_location_view.dart';
import 'dart:async';

import 'package:javacode/Modules/Features/Views/UI/login_view.dart';
import 'package:javacode/Modules/Features/Views/UI/no_connection_view.dart';
import 'package:javacode/Modules/Features/Views/UI/promo_detail_view.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/promo_detail_response_model.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';
import 'package:javacode/Utils/Services/promo_service.dart';
import 'package:uni_links/uni_links.dart';

import 'package:simple_connection_checker/simple_connection_checker.dart';

class MainController extends GetxController {
  RxBool isLoading = false.obs;
  PromoService promoService = PromoService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnection();
    // initUniLinks();
  }

  initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      if (initialLink != null) {
        if (initialLink.contains("promo/detail/")) {
          getPromoDetail(initialLink);
        }
      }
    } on PlatformException {
      // print('')
      return;
    }
  }

  getPromoDetail(String link) async {
    PromoDetailResponse? promoDetailResponse =
        await promoService.getPromoDetail(link);
    if (promoDetailResponse != null) {
      Get.offAll(PromoDetailView(
        promo: promoDetailResponse.data!,
        isFromLink: true,
      ));
    }
  }

  checkUserLogin() async {
    var box = Hive.box<User>('user');
    var orderBox = Hive.box<OrderHive>('order');

    if (box.values.isNotEmpty) {
      print(box.values.first.token ?? "kosong token");
      if (orderBox.values.isEmpty) {
        OrderHive orderHive = OrderHive();
        orderHive.idUser = box.values.first.idUser!;

        await orderBox.add(orderHive);
      } else {
        print("keys " + orderBox.keys.first.toString());
      }
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      if (initialLink != null) {
        if (initialLink.contains("promo/detail/")) {
          getPromoDetail(initialLink);
        }
      } else {
        print("initial link null");
        Get.offAll(FindLocationView());
      }
    } else {
      Get.offAll(LoginView());
    }
  }

  Future<void> checkConnection() async {
    isLoading = true.obs;
    update();
    bool _isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    // var listener = InternetConnectionChecker().onStatusChange.listen((status) {
    switch (_isConnected) {
      case true:
        isLoading = false.obs;
        update();
        print('Data connection is available.');
        checkUserLogin();
        // print('Data connection is available.');
        break;
      case false:
        isLoading = false.obs;
        update();
        print('You are disconnected from the internet.');

        // checkUserLogin();

        Get.offAll(NoConnection());
        break;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // listener.cancel();
    super.onClose();
  }
}
