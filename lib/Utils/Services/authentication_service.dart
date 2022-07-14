import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:javacode/Constant/Core/endpoint_const.dart';
import 'package:javacode/Modules/Models/login_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class AuthenticationService extends NetworkService {
  EndPointConst endPointConst = EndPointConst();
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
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
    // print(response.body);
    if (response.body['status_code'] == 200) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.body);
      return loginResponse;
    } else {
      Get.snackbar("Login Failed", "login_error_message".tr);
      return null;
    }
  }

  Future<LoginResponse?> loginWithGoogle() async {
    await googleSignIn.signIn();

    if (googleSignIn.currentUser != null) {
      final response =
          await post(super.baseUrlConst.baseUrl + endPointConst.login, {
        'is_google': 'is_google',
        'nama': googleSignIn.currentUser?.displayName,
        'email': googleSignIn.currentUser?.email
      });
      if (response.body['status_code'] == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.body);
        return loginResponse;
      } else {
        await logout();
        Get.snackbar("Login Failed", "email_didnt_registered".tr);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> logoutFromServer() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        super.baseUrlConst.baseUrl + super.endPointConst.logout,
        headers: headers);
    // print(response.body);
    if (response.isOk) {
      if (response.body['status_code'] == 200) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> logout() async {
    bool loggedOut = await logoutFromServer();
    if (loggedOut) {
      await auth.signOut();
      await googleSignIn.signOut();
    }
    return loggedOut;
  }
}
