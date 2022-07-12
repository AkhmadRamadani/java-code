import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Features/Controllers/find_location_controller.dart';
import 'package:javacode/Modules/Features/Views/UI/login_view.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';
import 'package:javacode/Utils/Services/authentication_service.dart';

class ProfileController extends GetxController {
  AuthenticationService authService = AuthenticationService();
  var orderBox = Hive.box<OrderHive>('order');
  var box = Hive.box<User>('user');

  logout() async {
    // await authService.logout();
    await orderBox.clear();
    OrderHive orderHive = OrderHive();
    orderHive.idUser = box.values.first.idUser;

    await orderBox.add(orderHive);

    // await box.clear();
    // Get.delete<FindLocationController>();
    // Get.offAll(LoginView());
    // Get.offUntil(GetPageRoute(page: () => LoginView()), );
    // Get.to(LoginView());
  }
}
