import 'dart:convert';

import 'package:get/get.dart';
import 'package:javacode/Modules/Models/user_detail_data_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class UserService extends NetworkService {
  Future<GetUserDetail?> getUserDetail() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        super.baseUrlConst.baseUrl +
            super.endPointConst.getUserDetail +
            super.box.values.first.idUser.toString(),
        headers: headers);
    print(response.body);
    if (response.isOk) {
      if (response.body['status_code'] == 200) {
        GetUserDetail userDetailResponse =
            GetUserDetail.fromJson(response.body);
        return userDetailResponse;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<GetUserDetail?> updateUserDetail(UserDetailData userDetailData) async {
    Map<String, String> headers = {
      'token': super.box.values.first.token ?? "",
      "Content-Type": "application/json"
    };

    Map<String, dynamic> userInfo = <String, dynamic>{
      'nama': userDetailData.nama,
      'tgl_lahir': userDetailData.tglLahir,
      'telepon': userDetailData.telepon,
      'email': userDetailData.email,
      'pin': userDetailData.pin
    };

    final response = await post(
        super.baseUrlConst.baseUrl +
            endPointConst.postUpdateUser +
            super.box.values.first.idUser.toString(),
        jsonEncode(userInfo),
        headers: headers);

    print(response.body);
    if (response.isOk) {
      if (response.body['status_code'] == 200) {
        GetUserDetail userDetailResponse =
            GetUserDetail.fromJson(response.body);
        return userDetailResponse;
      } else {
        Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
        return null;
      }
    } else {
      Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
      return null;
    }
  }

  Future<GetUserDetail?> updateUserDetailByKey(String key, String value) async {
    Map<String, String> headers = {
      'token': super.box.values.first.token ?? "",
      "Content-Type": "application/json"
    };
    print("key " + key);
    print("value " + value);
    // Map<String, dynamic> userInfo = <String, dynamic>{
    //   key: value,
    // };

    final response = await post(
        super.baseUrlConst.baseUrl +
            endPointConst.postUpdateUser +
            super.box.values.first.idUser.toString(),
        jsonEncode(<String, dynamic>{key: value}),
        headers: headers);

    print(response.body);
    if (response.isOk) {
      if (response.body['status_code'] == 200) {
        GetUserDetail userDetailResponse =
            GetUserDetail.fromJson(response.body);
        return userDetailResponse;
      } else {
        Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
        return null;
      }
    } else {
      Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
      return null;
    }
  }

  Future<GetUserDetail?> updateProfile(String key, String value) async {
    Map<String, String> headers = {
      'token': super.box.values.first.token ?? "",
      "Content-Type": "application/json"
    };
    print("key " + key);
    print("value " + value);
    // Map<String, dynamic> userInfo = <String, dynamic>{
    //   key: value,
    // };

    final response = await post(
        super.baseUrlConst.baseUrl +
            endPointConst.postUpdateProfile +
            super.box.values.first.idUser.toString(),
        jsonEncode(<String, dynamic>{key: value}),
        headers: headers);

    print(response.body);
    if (response.isOk) {
      if (response.body['status_code'] == 200) {
        GetUserDetail userDetailResponse =
            GetUserDetail.fromJson(response.body);
        return userDetailResponse;
      } else {
        Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
        return null;
      }
    } else {
      Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
      return null;
    }
  }

  Future<GetUserDetail?> updateKTP(String key, String value) async {
    Map<String, String> headers = {
      'token': super.box.values.first.token ?? "",
      "Content-Type": "application/json"
    };
    print("key " + key);
    print("value " + value);
    // Map<String, dynamic> userInfo = <String, dynamic>{
    //   key: value,
    // };

    final response = await post(
        super.baseUrlConst.baseUrl +
            endPointConst.postUpdateKTP +
            super.box.values.first.idUser.toString(),
        jsonEncode(<String, dynamic>{key: value}),
        headers: headers);

    print(response.body);
    if (response.isOk) {
      if (response.body['status_code'] == 200) {
        GetUserDetail userDetailResponse =
            GetUserDetail.fromJson(response.body);
        return userDetailResponse;
      } else {
        Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
        return null;
      }
    } else {
      Get.snackbar("Update Profil Gagal", "Ada kesalahan saat update profil");
      return null;
    }
  }
}
