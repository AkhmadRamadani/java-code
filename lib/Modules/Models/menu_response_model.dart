// To parse this JSON data, do
//
//     final getMenuResponse = getMenuResponseFromJson(jsonString);

import 'dart:convert';

GetMenuResponse getMenuResponseFromJson(String str) => GetMenuResponse.fromJson(json.decode(str));

String getMenuResponseToJson(GetMenuResponse data) => json.encode(data.toJson());

class GetMenuResponse {
    GetMenuResponse({
        this.statusCode,
        this.menu,
    });

    int? statusCode;
    List<Menu>? menu;

    factory GetMenuResponse.fromJson(Map<String, dynamic> json) => GetMenuResponse(
        statusCode: json["status_code"],
        menu: List<Menu>.from(json["data"].map((x) => Menu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(menu!.map((x) => x.toJson())),
    };
}

class Menu {
    Menu({
        this.idMenu,
        this.nama,
        this.kategori,
        this.harga,
        this.deskripsi,
        this.foto,
        this.status,
    });

    int? idMenu;
    String? nama;
    String? kategori;
    int? harga;
    String? deskripsi;
    String? foto;
    int? status;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        idMenu: json["id_menu"],
        nama: json["nama"],
        kategori: json["kategori"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        foto: json["foto"] == null ? null : json["foto"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "nama": nama,
        "kategori": kategori,
        "harga": harga,
        "deskripsi": deskripsi,
        "foto": foto == null ? null : foto,
        "status": status,
    };
}
