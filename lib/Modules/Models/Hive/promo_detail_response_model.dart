// To parse this JSON data, do
//
//     final promoDetailResponse = promoDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:javacode/Modules/Models/promo_response_model.dart';

PromoDetailResponse promoDetailResponseFromJson(String str) => PromoDetailResponse.fromJson(json.decode(str));

String promoDetailResponseToJson(PromoDetailResponse data) => json.encode(data.toJson());

class PromoDetailResponse {
    PromoDetailResponse({
        this.statusCode,
        this.data,
    });

    int? statusCode;
    Promo? data;

    factory PromoDetailResponse.fromJson(Map<String, dynamic> json) => PromoDetailResponse(
        statusCode: json["status_code"],
        data: Promo.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data!.toJson(),
    };
}

