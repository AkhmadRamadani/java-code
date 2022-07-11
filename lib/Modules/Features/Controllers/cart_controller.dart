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
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CartController extends GetxController {
  
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  var orderBox = Hive.box<OrderHive>('order');
  GetDiskonResponse? diskonResponse;
  DiskonService diskonService = DiskonService();
  Voucher? selectedVoucher;
  LocalAuthentication auth = LocalAuthentication();
  TextEditingController pinController = TextEditingController();
  var userBox = Hive.box<User>('user');
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  showDialogIdentify(BuildContext context, CartController value) {
    return showDialog(
      context: Get.overlayContext!,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            height: MediaQuery.of(context).size.width - 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(25),
            child: Column(children: [
              Text(
                "Verifikasi Pesanan",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Finger Print",
              ),
              SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  value.authenticateWithBiometrics();
                },
                child: Icon(
                  Icons.fingerprint,
                  color: colorConst.secondaryColor,
                  size: 142,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "atau",
                        style: TextStyle(
                          color: colorConst.greyTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(Get.overlayContext!).pop();
                  // showDialogVerifyWithPin(context, value);
                  // Navigator.pop(context);
                },
                child: Text(
                  "Verifikasi Menggunakan PIN",
                  style: TextStyle(
                    color: colorConst.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  checkPin() {
    if (pinController.text == userBox.values.first.pin) {
      Get.back(closeOverlays: true);
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
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyDiskon();
  }
}
