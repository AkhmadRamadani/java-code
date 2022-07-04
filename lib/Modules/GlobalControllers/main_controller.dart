import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';

import 'package:javacode/Modules/Features/Views/UI/login_view.dart';
import 'package:javacode/Modules/Features/Views/UI/no_connection_view.dart';

class MainController extends GetxController {
  RxBool isLoading = false.obs;
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
      Get.to(LoginView());
    } else {
      isLoading = false.obs;
      update();
      print('You are disconnected from the internet.');
      Get.to(NoConnection());
    }
    return await InternetConnectionChecker().hasConnection;
  }
}
