// To parse this JSON data, do
//
//     final getOrderResponse = getOrderResponseFromJson(jsonString);

import 'dart:convert';

GetOrderResponse getOrderResponseFromJson(String str) => GetOrderResponse.fromJson(json.decode(str));

String getOrderResponseToJson(GetOrderResponse data) => json.encode(data.toJson());

class GetOrderResponse {
    GetOrderResponse({
        this.statusCode,
        this.order,
    });

    int? statusCode;
    List<Order>? order = [];

    factory GetOrderResponse.fromJson(Map<String, dynamic> json) => GetOrderResponse(
        statusCode: json["status_code"],
        order: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(order!.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.idOrder,
        this.noStruk,
        this.nama,
        this.totalBayar,
        this.tanggal,
        this.status,
        this.menu,
    });

    int? idOrder;
    String? noStruk;
    String? nama;
    double? totalBayar;
    String? tanggal;
    int? status;
    List<MenuOrder>? menu = [];

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        totalBayar: json["total_bayar"],
        tanggal: json["tanggal"],
        status: json["status"],
        menu: List<MenuOrder>.from(json["menu"].map((x) => MenuOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "no_struk": noStruk,
        "nama": nama,
        "total_bayar": totalBayar,
        "tanggal": tanggal,
        "status": status,
        "menu": List<dynamic>.from(menu!.map((x) => x.toJson())),
    };
}

class MenuOrder {
    MenuOrder({
        this.idMenu,
        this.kategori,
        this.topping,
        this.nama,
        this.foto,
        this.jumlah,
        this.harga,
        this.total,
        this.catatan,
    });

    int? idMenu;
    String? kategori;
    String? topping;
    String? nama;
    String? foto;
    int? jumlah;
    String? harga;
    double? total;
    String? catatan;

    factory MenuOrder.fromJson(Map<String, dynamic> json) => MenuOrder(
        idMenu: json["id_menu"],
        kategori: json["kategori"],
        topping: json["topping"],
        nama: json["nama"],
        foto: json["foto"],
        jumlah: json["jumlah"],
        harga: json["harga"],
        total: json["total"],
        catatan: json["catatan"],
    );

    Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "kategori": kategori,
        "topping": topping,
        "nama": nama,
        "foto": foto,
        "jumlah": jumlah,
        "harga": harga,
        "total": total,
        "catatan": catatan,
    };
}
