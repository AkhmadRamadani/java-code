// To parse this JSON data, do
//
//     final getHistoryOrderResponse = getHistoryOrderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:javacode/Modules/Models/order_response_model.dart';

GetHistoryOrderResponse getHistoryOrderResponseFromJson(String str) =>
    GetHistoryOrderResponse.fromJson(json.decode(str));

String getHistoryOrderResponseToJson(GetHistoryOrderResponse data) =>
    json.encode(data.toJson());

class GetHistoryOrderResponse {
  GetHistoryOrderResponse({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory GetHistoryOrderResponse.fromJson(Map<String, dynamic> json) =>
      GetHistoryOrderResponse(
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.listData,
    this.totalPrice,
    this.totalOrder,
  });

  List<Order>? listData;
  int? totalPrice;
  int? totalOrder;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        listData:
            List<Order>.from(json["listData"].map((x) => Order.fromJson(x))),
        totalPrice: json["totalPrice"],
        totalOrder: json["totalOrder"],
      );

  Map<String, dynamic> toJson() => {
        "listData": List<dynamic>.from(listData!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "totalOrder": totalOrder,
      };
}
