// To parse this JSON data, do
//
//     final getDiskonResponse = getDiskonResponseFromJson(jsonString);

import 'dart:convert';

GetDiskonResponse getDiskonResponseFromJson(String str) => GetDiskonResponse.fromJson(json.decode(str));

String getDiskonResponseToJson(GetDiskonResponse data) => json.encode(data.toJson());

class GetDiskonResponse {
    GetDiskonResponse({
        this.statusCode,
        this.diskon,
    });

    int? statusCode;
    List<Diskon>? diskon;

    factory GetDiskonResponse.fromJson(Map<String, dynamic> json) => GetDiskonResponse(
        statusCode: json["status_code"],
        diskon: List<Diskon>.from(json["data"].map((x) => Diskon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(diskon!.map((x) => x.toJson())),
    };
}

class Diskon {
    Diskon({
        this.idDiskon,
        this.idUser,
        this.namaUser,
        this.nama,
        this.diskon,
    });

    int? idDiskon;
    int? idUser;
    String? namaUser;
    String? nama;
    int? diskon;

    factory Diskon.fromJson(Map<String, dynamic> json) => Diskon(
        idDiskon: json["id_diskon"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        nama: json["nama"],
        diskon: json["diskon"],
    );

    Map<String, dynamic> toJson() => {
        "id_diskon": idDiskon,
        "id_user": idUser,
        "nama_user": namaUser,
        "nama": nama,
        "diskon": diskon,
    };
}
