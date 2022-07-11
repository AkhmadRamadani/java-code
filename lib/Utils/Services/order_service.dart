import 'dart:convert';

import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class OrderService extends NetworkService {
  Future<GetOrderResponse?> getOrderListByStatus() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};

    final response = await get(
        super.baseUrlConst.baseUrl +
            super.endPointConst.getOrderByStatus +
            '1/0',
        headers: headers);
    print(response.body);
    if (response.body['status_code'] == 200) {
      GetOrderResponse orderResponse = GetOrderResponse.fromJson(response.body);
      return orderResponse;
    } else {
      return null;
    }
  }

  Future<bool> orderRequest(OrderHive orderData) async {
    Map<String, String> headers = {
      'token': super.box.values.first.token ?? "",
      "Content-Type": "application/json"
    };
    List<dynamic> menus = [];
    for (var menu in orderData.menu!) {
      // List<dynamic> listToping = [];
      // for (var toping in menu.topping!) {
      //   listToping.add(toping);
      // }
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

    print(response.body);
    if (response.body['status_code'] == 200) {
      // LoginResponse loginResponse = LoginResponse.fromJson(response.body);
      return true;
    } else {
      // Get.snackbar("Login Failed", "Silakan cek email dan password anda!");
      return false;
    }
  }
}
