// To parse this JSON data, do
//
//     final getUserDetail = getUserDetailFromJson(jsonString);

import 'dart:convert';

GetUserDetail getUserDetailFromJson(String str) => GetUserDetail.fromJson(json.decode(str));

String getUserDetailToJson(GetUserDetail data) => json.encode(data.toJson());

class GetUserDetail {
    GetUserDetail({
        this.statusCode,
        this.userDetailData,
    });

    int? statusCode;
    UserDetailData? userDetailData;

    factory GetUserDetail.fromJson(Map<String, dynamic> json) => GetUserDetail(
        statusCode: json["status_code"],
        userDetailData: UserDetailData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": userDetailData!.toJson(),
    };
}

class UserDetailData {
    UserDetailData({
        this.idUser,
        this.nama,
        this.email,
        this.tglLahir,
        this.alamat,
        this.telepon,
        this.foto,
        this.ktp,
        this.pin,
        this.status,
        this.isCustomer,
        this.rolesId,
        this.roles,
    });

    int? idUser;
    String? nama;
    String? email;
    String? tglLahir;
    String? alamat;
    dynamic telepon;
    dynamic foto;
    dynamic ktp;
    String? pin;
    int? status;
    int? isCustomer;
    int? rolesId;
    String? roles;

    factory UserDetailData.fromJson(Map<String, dynamic> json) => UserDetailData(
        idUser: json["id_user"],
        nama: json["nama"],
        email: json["email"],
        tglLahir: json["tgl_lahir"],
        alamat: json["alamat"],
        telepon: json["telepon"],
        foto: json["foto"],
        ktp: json["ktp"],
        pin: json["pin"],
        status: json["status"],
        isCustomer: json["is_customer"],
        rolesId: json["roles_id"],
        roles: json["roles"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "email": email,
        "tgl_lahir": tglLahir,
        "alamat": alamat,
        "telepon": telepon,
        "foto": foto,
        "ktp": ktp,
        "pin": pin,
        "status": status,
        "is_customer": isCustomer,
        "roles_id": rolesId,
        "roles": roles,
    };
}
