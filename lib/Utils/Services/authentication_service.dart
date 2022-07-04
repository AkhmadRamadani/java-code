import 'dart:convert';

import 'package:get/get.dart';
import 'package:javacode/Constant/Core/endpoint_const.dart';
import 'package:javacode/Modules/Models/login_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class AuthenticationService extends NetworkService {
  EndPointConst endPointConst = EndPointConst();

  Future<LoginResponse?> loginRequest(String email, String password) async {
    final response = await post(
        super.baseUrlConst.baseUrl + endPointConst.login,
        {'email': email, 'password': password});
    print(response.body);
    if (response.body['status_code'] == 200) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(jsonDecode(response.body));
      return loginResponse;
    } else {
      Get.snackbar("Login Failed", "Silakan cek email dan password anda!");
      return null;
    }
  }
}
