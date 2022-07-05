import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:javacode/Constant/Core/base_url_const.dart';
import 'package:javacode/Modules/Features/Views/UI/find_location_view.dart';
import 'package:javacode/Modules/Models/login_response_model.dart';
import 'package:javacode/Utils/Services/authentication_service.dart';

class LoginController extends GetxController {
  RxBool isPasswordShowed = true.obs;
  RxBool isLoading = false.obs;
  AuthenticationService authService = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  showPassword() {
    print("show pass");
    isPasswordShowed = true.obs;
    update();
  }

  unShowPassword() {
    print("unshow pass");

    isPasswordShowed = false.obs;
    update();
  }

  loginFunction(String email, String password) async {
    // Response res = get(Uri.parse("uri"));

    if (email.length == 0) {
      Get.snackbar("Email Kosong", "Email wajib diisikan");
      return;
    }
    if (!email.contains("@") && !email.contains(".")) {
      Get.snackbar("Email Invalid", "Periksa kembali email anda");
      return;
    }
    if (password.length == 0) {
      Get.snackbar("Password Invalid", "Panjang password minimal 8 karakter");
      return;
    }
    isLoading = true.obs;
    update();
    // http.Response res = await http.post(
    //   Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'email': email,
    //     'password': password
    //   }),
    // );

    LoginResponse? loginRes = await authService.loginRequest(email, password);

    if (loginRes != null) {
      isLoading = false.obs;
      update();
      Get.to(FindLocationView());
    } else {
      isLoading = false.obs;
      update();
      Get.snackbar("Login Failed", "Periksa kembali email dan password Anda");
    }
  }

  loginWithGoogle() async {
    isLoading = true.obs;
    LoginResponse? loginRes = await authService.loginWithGoogle();

    if (loginRes != null) {
      isLoading = false.obs;
      update();
      Get.to(FindLocationView());
    } else {
      isLoading = false.obs;
      update();
      // Get.snackbar("Login Failed", "Periksa kembali email dan password Anda");
    }
  }

  logout() async{
    await authService.logout();
  }
}
