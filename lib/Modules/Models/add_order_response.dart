// To parse this JSON data, do
//
//     final addOrderResponse = addOrderResponseFromJson(jsonString);

import 'dart:convert';

AddOrderResponse addOrderResponseFromJson(String str) => AddOrderResponse.fromJson(json.decode(str));

String addOrderResponseToJson(AddOrderResponse data) => json.encode(data.toJson());

class AddOrderResponse {
    AddOrderResponse({
        this.statusCode,
        this.dataOrder,
    });

    int? statusCode;
    DataOrder? dataOrder;

    factory AddOrderResponse.fromJson(Map<String, dynamic> json) => AddOrderResponse(
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
        this.idOrder,
        this.message,
        this.noStruk,
    });

    int? idOrder;
    String? message;
    String? noStruk;

    factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        idOrder: json["id_order"],
        message: json["message"],
        noStruk: json["no_struk"],
    );

    Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "message": message,
        "no_struk": noStruk,
    };
}
