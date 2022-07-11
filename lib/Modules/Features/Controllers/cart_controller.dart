import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';
import 'package:javacode/Modules/Models/diskon_response_model.dart';
import 'package:javacode/Modules/Models/my_voucher_response_model.dart';
import 'package:javacode/Utils/Services/diskon_service.dart';
import 'package:javacode/Utils/Services/order_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CartController extends GetxController {
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  var orderBox = Hive.box<OrderHive>('order');
  GetDiskonResponse? diskonResponse;

  DiskonService diskonService = DiskonService();
  OrderService orderService = OrderService();

  Voucher? selectedVoucher;
  LocalAuthentication auth = LocalAuthentication();
  TextEditingController pinController = TextEditingController();
  var userBox = Hive.box<User>('user');
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  RxBool isSuccess = false.obs;
  RxBool isLoading = false.obs;

  checkPin() async {
    if (pinController.text == userBox.values.first.pin) {
      // Get.back(closeOverlays: true);
      Get.close(2);
      isLoading = true.obs;
      update();
      await checkout();
      isLoading = false.obs;

      update();
    } else {
      errorController.add(ErrorAnimationType.shake);
    }
  }

  getMyDiskon() async {
    GetDiskonResponse? diskonResponse = await diskonService.getMyDiskon();
    if (diskonResponse != null) {
      this.diskonResponse = diskonResponse;
    }
    update();
  }

  double getDiskonAmount() {
    double diskon = 0;
    if (diskonResponse != null) {
      this.diskonResponse!.diskon!.forEach((element) {
        int percentage = element.diskon ?? 0;

        diskon += percentage / 100 * orderBox.values.first.totalBayar!;
      });
    }
    update();
    return diskon;
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan fingerprint untuk melanjutkan pembelian',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);

      return;
    }

    // if (!mounted) {
    //   return;
    // }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    // setState(() {
    //   _authorized = message;
    // });
  }

  checkout() async {
    OrderHive requestFix = orderBox.values.first;
    if (selectedVoucher != null) {
      double totalBayarTemp =
          requestFix.totalBayar! - selectedVoucher!.nominal!;
      requestFix.idVoucher = selectedVoucher!.idVoucher;
      if (totalBayarTemp < 0) {
        totalBayarTemp = 0;
      }
      requestFix.totalBayar = totalBayarTemp;
    }

    if (diskonResponse != null && selectedVoucher == null) {
      if (requestFix.totalBayar! > 10000) {
        requestFix.potongan = getDiskonAmount();
        double totalBayarTemp = requestFix.totalBayar! - getDiskonAmount();
        if (totalBayarTemp < 0) {
          totalBayarTemp = 0;
        }
        requestFix.totalBayar = totalBayarTemp;
      }
    }
    bool requestOrder = await orderService.orderRequest(requestFix);
    if (requestOrder) {
      isSuccess = true.obs;
      OrderHive tempOrderHive = OrderHive();
      tempOrderHive.idUser = userBox.values.first.idUser;
      orderBox.put(orderBox.keys.first, tempOrderHive);
    } else {
      // OrderHive tempOrderHive = orderBox.values.first;
      // orderBox.put(orderBox.keys.first, tempOrderHive);
      
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyDiskon();
  }
}
