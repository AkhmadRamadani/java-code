import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Services/order_service.dart';

class HistoryPesananController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;
  GetOrderResponse? order;
  OrderService historyService =  OrderService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = TabController(vsync: this, length: 2);
    getListOrderOnTracking();
  }

  getListOrderOnTracking() async {
    GetOrderResponse? order = await historyService.getOrderListByStatus();

    if (order != null) {
      this.order = order;
    }

    update();
  }

}
