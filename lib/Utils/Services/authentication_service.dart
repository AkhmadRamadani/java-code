import 'dart:convert';

import 'package:get/get.dart';
import 'package:javacode/Constant/Core/endpoint_const.dart';
import 'package:javacode/Modules/Models/login_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class AuthenticationService extends NetworkService {
  EndPointConst endPointConst = EndPointConst();

  //  * User Login
  //  * @author: Akhmad Ramadani <akhmdramadani18@gmail.com>
  //  * 
  //  * User do a login with their email and possword 
  //  * Parameter: 
  //  * [email] String
  //  * [password] String 
  //  * 
  //  * If there is user account with their information given
  //  * it will return LoginResponse and if not it will return null
  //  * 
  //  */
  
  Future<LoginResponse?> loginRequest(String email, String password) async {
    final response = await post(
        super.baseUrlConst.baseUrl + endPointConst.login,
        {'email': email, 'password': password});

    if (response.body['status_code'] == 200) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.body);
      return loginResponse;
    } else {
      Get.snackbar("Login Failed", "Silakan cek email dan password anda!");
      return null;
    }
  }
}
