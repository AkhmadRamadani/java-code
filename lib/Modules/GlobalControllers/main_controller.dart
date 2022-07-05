import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:javacode/Modules/Features/Views/UI/find_location_view.dart';
import 'dart:async';

import 'package:javacode/Modules/Features/Views/UI/login_view.dart';
import 'package:javacode/Modules/Features/Views/UI/no_connection_view.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';

class MainController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnection();
  }

  checkUserLogin() async {
    Box<User> box = await Hive.openBox<User>('user'); 
    if(box.values.isNotEmpty){
      print(box.values.first.token ?? "kosong token");
      Get.to(FindLocationView());

    }else{
      Get.to(LoginView());

    }
  }

  Future<bool> checkConnection() async {
    isLoading = true.obs;
    update();
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await InternetConnectionChecker().hasConnection);
    // returns a bool
    bool isHaveConnection = await InternetConnectionChecker().hasConnection;

    if (isHaveConnection) {
      isLoading = false.obs;
      update();
      print('Data connection is available.');
      checkUserLogin();
    } else {
      isLoading = false.obs;
      update();
      print('You are disconnected from the internet.');
      Get.to(NoConnection());
    }
    return await InternetConnectionChecker().hasConnection;
  }
}
