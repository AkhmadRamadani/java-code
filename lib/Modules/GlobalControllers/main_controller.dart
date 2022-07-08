import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
      }else{
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

  Future<bool> checkConnection() async {
    isLoading = true.obs;
    update();
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await InternetConnectionChecker().hasConnection);
    // returns a bool
    bool isHaveConnection = await InternetConnectionChecker().hasConnection;

    if (isHaveConnection) {
      isLoading = false.obs;
      update();
      print('Data connection is available.');
      checkUserLogin();
    } else {
      isLoading = false.obs;
      update();
      print('You are disconnected from the internet.');
      Get.to(NoConnection());
    }
    return await InternetConnectionChecker().hasConnection;
  }
}
