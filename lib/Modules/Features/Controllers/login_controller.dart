import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Features/Views/UI/find_location_view.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart' as user_hive;
import 'package:javacode/Modules/Models/Hive/akses_hive_model.dart'
    as akses_hive;
import 'package:javacode/Modules/Models/login_response_model.dart';
import 'package:javacode/Utils/Services/authentication_service.dart';

class LoginController extends GetxController {
  RxBool isPasswordShowed = true.obs;
  RxBool isLoading = false.obs;
  AuthenticationService authService = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  showPassword() {
    // print("show pass");
    isPasswordShowed = true.obs;
    update();
  }

  unShowPassword() {
    // print("unshow pass");

    isPasswordShowed = false.obs;
    update();
  }

  loginFunction(String email, String password) async {
    var box = Hive.box<user_hive.User>('user');
    var orderBox = Hive.box<OrderHive>('order');

    if (email.length == 0) {
      Get.snackbar("email_null_error_title".tr, "email_null_error_message".tr);
      return;
    }
    if (!email.contains("@") && !email.contains(".")) {
      Get.snackbar("Email Invalid", "check_your_email".tr);
      return;
    }
    if (password.length == 0) {
      Get.snackbar("Password Invalid", "password_minim_8_char".tr);
      return;
    }
    isLoading = true.obs;
    update();
    LoginResponse? loginRes = await authService.loginRequest(email, password);

    if (loginRes != null) {
      user_hive.User userData = user_hive.User();
      userData.email = loginRes.data?.user?.email;
      userData.foto = loginRes.data?.user?.foto;
      userData.idUser = loginRes.data?.user?.idUser;
      userData.isCustomer = loginRes.data?.user?.isCustomer;
      userData.isGoogle = loginRes.data?.user?.isGoogle;
      userData.mRolesId = loginRes.data?.user?.mRolesId;
      userData.nama = loginRes.data?.user?.nama;
      userData.pin = loginRes.data?.user?.pin;
      userData.roles = loginRes.data?.user?.roles;
      userData.token = loginRes.data?.token;

      akses_hive.Akses aksesUser = akses_hive.Akses();
      aksesUser.authAkses = loginRes.data?.user?.akses?.authAkses;
      aksesUser.authUser = loginRes.data?.user?.akses?.authUser;
      aksesUser.laporanCustomer = loginRes.data?.user?.akses?.laporanCustomer;
      aksesUser.laporanMenu = loginRes.data?.user?.akses?.laporanMenu;
      aksesUser.settingCustomer = loginRes.data?.user?.akses?.settingCustomer;
      aksesUser.settingDiskon = loginRes.data?.user?.akses?.settingDiskon;
      aksesUser.settingVoucher = loginRes.data?.user?.akses?.settingVoucher;
      aksesUser.settingMenu = loginRes.data?.user?.akses?.settingMenu;
      aksesUser.settingPromo = loginRes.data?.user?.akses?.settingPromo;

      userData.akses = aksesUser;

      // userData.akses = loginRes.data?.user?.akses??;
      OrderHive orderHive = OrderHive();
      orderHive.idUser = userData.idUser;

      await orderBox.add(orderHive);
      await box.clear();
      await box.add(userData);
      isLoading = false.obs;
      update();
      Get.to(FindLocationView());
    } else {
      isLoading = false.obs;
      update();
      Get.snackbar("Login Failed", "login_error_message".tr);
    }
  }

  loginWithGoogle() async {
    var box = Hive.box<user_hive.User>('user');
    var orderBox = Hive.box<OrderHive>('order');

    isLoading = true.obs;
    LoginResponse? loginRes = await authService.loginWithGoogle();

    if (loginRes != null) {
      user_hive.User userData = user_hive.User();
      userData.email = loginRes.data?.user?.email;
      userData.foto = loginRes.data?.user?.foto;
      userData.idUser = loginRes.data?.user?.idUser;
      userData.isCustomer = loginRes.data?.user?.isCustomer;
      userData.isGoogle = loginRes.data?.user?.isGoogle;
      userData.mRolesId = loginRes.data?.user?.mRolesId;
      userData.nama = loginRes.data?.user?.nama;
      userData.pin = loginRes.data?.user?.pin;
      userData.roles = loginRes.data?.user?.roles;
      userData.token = loginRes.data?.token;

      akses_hive.Akses aksesUser = akses_hive.Akses();
      aksesUser.authAkses = loginRes.data?.user?.akses?.authAkses;
      aksesUser.authUser = loginRes.data?.user?.akses?.authUser;
      aksesUser.laporanCustomer = loginRes.data?.user?.akses?.laporanCustomer;
      aksesUser.laporanMenu = loginRes.data?.user?.akses?.laporanMenu;
      aksesUser.settingCustomer = loginRes.data?.user?.akses?.settingCustomer;
      aksesUser.settingDiskon = loginRes.data?.user?.akses?.settingDiskon;
      aksesUser.settingVoucher = loginRes.data?.user?.akses?.settingVoucher;
      aksesUser.settingMenu = loginRes.data?.user?.akses?.settingMenu;
      aksesUser.settingPromo = loginRes.data?.user?.akses?.settingPromo;

      userData.akses = aksesUser;

      // userData.akses = loginRes.data?.user?.akses??;
      OrderHive orderHive = OrderHive();
      orderHive.idUser = userData.idUser;

      await orderBox.add(orderHive);
      await box.clear();
      await box.add(userData);
      isLoading = false.obs;
      update();
      Get.to(FindLocationView());
    } else {
      isLoading = false.obs;
      update();
      // Get.snackbar("Login Failed", "Periksa kembali email dan password Anda");
    }
  }

  logout() async {
    await authService.logout();
  }
}
