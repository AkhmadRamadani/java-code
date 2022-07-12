// To parse this JSON data, do
//
//     final getOrderDetailResponse = getOrderDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:javacode/Modules/Models/order_response_model.dart';

GetOrderDetailResponse getOrderDetailResponseFromJson(String str) =>
    GetOrderDetailResponse.fromJson(json.decode(str));

String getOrderDetailResponseToJson(GetOrderDetailResponse data) =>
    json.encode(data.toJson());

class GetOrderDetailResponse {
  GetOrderDetailResponse({
    this.statusCode,
    this.dataOrder,
  });

  int? statusCode;
  DataOrder? dataOrder;

  factory GetOrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetOrderDetailResponse(
        statusCode: json["status_code"],
        dataOrder: DataOrder.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": dataOrder!.toJson(),
      };
}

class DataOrder {
  DataOrder({
    this.order,
    this.detail,
  });

  OrderDetail? order;
  List<MenuOrder>? detail = [];

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        order: OrderDetail.fromJson(json["order"]),
        detail: List<MenuOrder>.from(
            json["detail"].map((x) => MenuOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order!.toJson(),
        "detail": List<dynamic>.from(detail!.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.idOrder,
    this.noStruk,
    this.nama,
    this.idVoucher,
    this.namaVoucher,
    this.diskon,
    this.potongan,
    this.totalBayar,
    this.tanggal,
    this.status,
  });

  int? idOrder;
  String? noStruk;
  String? nama;
  int? idVoucher;
  String? namaVoucher;
  int? diskon;
  int? potongan;
  int? totalBayar;
  String? tanggal;
  int? status;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        idVoucher: json["id_voucher"],
        namaVoucher: json["nama_voucher"],
        diskon: json["diskon"],
        potongan: json["potongan"],
        totalBayar: json["total_bayar"],
        tanggal: json["tanggal"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "no_struk": noStruk,
        "nama": nama,
        "id_voucher": idVoucher,
        "nama_voucher": namaVoucher,
        "diskon": diskon,
        "potongan": potongan,
        "total_bayar": totalBayar,
        "tanggal": tanggal,
        "status": status,
      };
}
