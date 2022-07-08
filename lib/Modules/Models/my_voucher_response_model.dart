// To parse this JSON data, do
//
//     final getMyVoucherResponse = getMyVoucherResponseFromJson(jsonString);

import 'dart:convert';

GetMyVoucherResponse getMyVoucherResponseFromJson(String str) =>
    GetMyVoucherResponse.fromJson(json.decode(str));

String getMyVoucherResponseToJson(GetMyVoucherResponse data) =>
    json.encode(data.toJson());

class GetMyVoucherResponse {
  GetMyVoucherResponse({
    this.statusCode,
    this.voucher,
  });

  int? statusCode;
  List<Voucher>? voucher;

  factory GetMyVoucherResponse.fromJson(Map<String, dynamic> json) =>
      GetMyVoucherResponse(
        statusCode: json["status_code"],
        voucher:
            List<Voucher>.from(json["data"].map((x) => Voucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(voucher!.map((x) => x.toJson())),
      };
}

class Voucher {
  Voucher({
    this.idVoucher,
    this.nama,
    this.idUser,
    this.namaUser,
    this.nominal,
    this.infoVoucher,
    this.periodeMulai,
    this.periodeSelesai,
    this.type,
    this.status,
    this.catatan,
    this.isSelected = false,
  });

  int? idVoucher;
  String? nama;
  int? idUser;
  String? namaUser;
  int? nominal;
  String? infoVoucher;
  String? periodeMulai;
  String? periodeSelesai;
  int? type;
  int? status;
  String? catatan;
  bool? isSelected;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        idVoucher: json["id_voucher"],
        nama: json["nama"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        nominal: json["nominal"],
        infoVoucher: json["info_voucher"],
        periodeMulai: json["periode_mulai"],
        periodeSelesai: json["periode_selesai"],
        type: json["type"],
        status: json["status"],
        catatan: json["catatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_voucher": idVoucher,
        "nama": nama,
        "id_user": idUser,
        "nama_user": namaUser,
        "nominal": nominal,
        "info_voucher": infoVoucher,
        "periode_mulai": periodeMulai,
        "periode_selesai": periodeSelesai,
        "type": type,
        "status": status,
        "catatan": catatan,
      };
}
