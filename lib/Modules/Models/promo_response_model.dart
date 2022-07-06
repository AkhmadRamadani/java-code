// To parse this JSON data, do
//
//     final promoResponse = promoResponseFromJson(jsonString);

import 'dart:convert';

PromoResponse promoResponseFromJson(String str) =>
    PromoResponse.fromJson(json.decode(str));

String promoResponseToJson(PromoResponse data) => json.encode(data.toJson());

class PromoResponse {
  PromoResponse({
    this.statusCode,
    this.promo,
  });

  int? statusCode;
  List<Promo>? promo;

  factory PromoResponse.fromJson(Map<String, dynamic> json) => PromoResponse(
        statusCode: json["status_code"],
        promo: List<Promo>.from(json["data"].map((x) => Promo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datas": List<dynamic>.from(promo!.map((x) => x.toJson())),
      };
}

class Promo {
  Promo({
    this.idPromo,
    this.nama,
    this.type,
    this.diskon,
    this.nominal,
    this.kadaluarsa,
    this.syaratKetentuan,
    this.foto,
    this.createdAt,
    this.createdBy,
    this.isDeleted,
  });

  int? idPromo;
  String? nama;
  String? type;
  int? diskon;
  int? nominal;
  int? kadaluarsa;
  String? syaratKetentuan;
  String? foto;
  int? createdAt;
  int? createdBy;
  int? isDeleted;

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        idPromo: json["id_promo"],
        nama: json["nama"],
        type: json["type"],
        diskon: json["diskon"] == null ? null : json["diskon"],
        nominal: json["nominal"],
        kadaluarsa: json["kadaluarsa"] == null ? null : json["kadaluarsa"],
        syaratKetentuan: json["syarat_ketentuan"],
        foto: json["foto"] == null ? null : json["foto"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id_promo": idPromo,
        "nama": nama,
        "type": type,
        "diskon": diskon == null ? null : diskon,
        "nominal": nominal,
        "kadaluarsa": kadaluarsa == null ? null : kadaluarsa,
        "syarat_ketentuan": syaratKetentuan,
        "foto": foto == null ? null : foto,
        "created_at": createdAt,
        "created_by": createdBy,
        "is_deleted": isDeleted,
      };
}
