// To parse this JSON data, do
//
//     final menuDetailResponse = menuDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:javacode/Modules/Models/menu_response_model.dart';

MenuDetailResponse menuDetailResponseFromJson(String str) => MenuDetailResponse.fromJson(json.decode(str));

String menuDetailResponseToJson(MenuDetailResponse data) => json.encode(data.toJson());

class MenuDetailResponse {
    MenuDetailResponse({
        this.statusCode,
        this.data,
    });

    int? statusCode;
    Data? data;

    factory MenuDetailResponse.fromJson(Map<String, dynamic> json) => MenuDetailResponse(
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.menu,
        this.topping,
        this.level,
    });

    Menu? menu;
    List<Level>? topping;
    List<Level>? level;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        menu: Menu.fromJson(json["menu"]),
        topping: List<Level>.from(json["topping"].map((x) => Level.fromJson(x))),
        level: List<Level>.from(json["level"].map((x) => Level.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu": menu?.toJson(),
        "topping": List<dynamic>.from(topping!.map((x) => x.toJson())),
        "level": List<dynamic>.from(level!.map((x) => x.toJson())),
    };
}

class Level {
    Level({
        this.idDetail,
        this.idMenu,
        this.keterangan,
        this.type,
        this.harga,
        this.isSelected = false
    });

    int? idDetail;
    int? idMenu;
    String? keterangan;
    String? type;
    int? harga;
    bool? isSelected;

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        idDetail: json["id_detail"],
        idMenu: json["id_menu"],
        keterangan: json["keterangan"],
        type: json["type"],
        harga: json["harga"],
    );

    Map<String, dynamic> toJson() => {
        "id_detail": idDetail,
        "id_menu": idMenu,
        "keterangan": keterangan,
        "type": type,
        "harga": harga,
    };
}
