import 'dart:ffi';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/diskon_response_model.dart';
import 'package:javacode/Modules/Models/my_voucher_response_model.dart';
import 'package:javacode/Utils/Services/diskon_service.dart';

class CartController extends GetxController {
  var orderBox = Hive.box<OrderHive>('order');
  GetDiskonResponse? diskonResponse;
  DiskonService diskonService = DiskonService();
  Voucher? selectedVoucher;
  
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyDiskon();
  }
}
