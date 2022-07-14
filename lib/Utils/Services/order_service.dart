import 'dart:convert';

import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/add_order_response.dart';
import 'package:javacode/Modules/Models/history_order_response_model.dart';
import 'package:javacode/Modules/Models/order_detail_response_model.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class OrderService extends NetworkService {
  Future<GetOrderResponse?> getOrderListByStatus() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};

    final response = await get(
        super.baseUrlConst.baseUrl + super.endPointConst.getOrderByUser + "1",
        headers: headers);
    // print(response.body);
    if (response.body['status_code'] == 200) {
      GetOrderResponse orderResponse = GetOrderResponse.fromJson(response.body);
      return orderResponse;
    } else {
      return null;
    }
  }

  Future<GetOrderResponse?> getOrderListByUser() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};

    final response = await get(
        super.baseUrlConst.baseUrl +
            super.endPointConst.getOrderByUser +
            super.box.values.first.idUser.toString(),
        headers: headers);
    // print(response.body);
    if (response.body['status_code'] == 200) {
      GetOrderResponse orderResponse = GetOrderResponse.fromJson(response.body);
      return orderResponse;
    } else {
      return null;
    }
  }

  Future<GetHistoryOrderResponse?> getHistoryOrder() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};

    final response = await post(
        super.baseUrlConst.baseUrl +
            super.endPointConst.getHistoryOrder +
            super.box.values.first.idUser.toString(),
        jsonEncode(<String, dynamic>{}),
        headers: headers);
    // print(response.body);
    if (response.body['status_code'] == 200) {
      GetHistoryOrderResponse orderResponse =
          GetHistoryOrderResponse.fromJson(response.body);
      return orderResponse;
    } else {
      return null;
    }
  }

  Future<GetOrderDetailResponse?> getDetailOrder(String id) async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};

    final response = await get(
        super.baseUrlConst.baseUrl + super.endPointConst.getOrderDetal + id,
        headers: headers);
    // print(response.body);
    if (response.body['status_code'] == 200) {
      GetOrderDetailResponse detailOrderResponse =
          GetOrderDetailResponse.fromJson(response.body);
      return detailOrderResponse;
    } else {
      return null;
    }
  }

  Future<AddOrderResponse?> orderRequest(OrderHive orderData) async {
    Map<String, String> headers = {
      'token': super.box.values.first.token ?? "",
      "Content-Type": "application/json"
    };
    List<dynamic> menus = [];
    for (var menu in orderData.menu!) {
      menus.add({
        'id_menu': menu.id_menu,
        'harga': menu.harga,
        'level': menu.level,
        'topping': menu.topping,
        'jumlah': menu.jumlah
      });
    }
    final response = await post(
        super.baseUrlConst.baseUrl + endPointConst.addOrder,
        jsonEncode(<String, dynamic>{
          'order': {
            'id_user': orderData.idUser,
            'id_voucher': orderData.idVoucher,
            'potongan': orderData.potongan,
            'total_bayar': orderData.totalBayar,
          },
          'menu': menus
        }),
        headers: headers);

    // print(response.body);
    if (response.body['status_code'] == 200) {
      AddOrderResponse addOrderResponse =
          AddOrderResponse.fromJson(response.body);
      // var da
      return addOrderResponse;
    } else {
      // Get.snackbar("Login Failed", "Silakan cek email dan password anda!");
      return null;
    }
  }

  Future<AddOrderResponse?> reOrderReques(Order orderData) async {
    Map<String, String> headers = {
      'token': super.box.values.first.token ?? "",
      "Content-Type": "application/json"
    };
    List<dynamic> menus = [];
    for (var menu in orderData.menu!) {
      menus.add({
        'id_menu': menu.idMenu,
        'harga': menu.harga,
        'level': 0,
        'topping': menu.topping,
        'jumlah': menu.jumlah
      });
    }
    final response = await post(
        super.baseUrlConst.baseUrl + endPointConst.addOrder,
        jsonEncode(<String, dynamic>{
          'order': {
            'id_user': super.box.values.first.idUser,
            'id_voucher': 0,
            'potongan': 0,
            'total_bayar': orderData.totalBayar,
          },
          'menu': menus
        }),
        headers: headers);

    // print(response.body);
    if (response.body['status_code'] == 200) {
      AddOrderResponse addOrderResponse =
          AddOrderResponse.fromJson(response.body);
      // var da
      return addOrderResponse;
    } else {
      // Get.snackbar("Login Failed", "Silakan cek email dan password anda!");
      return null;
    }
  }
}
