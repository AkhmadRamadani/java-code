import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';

class LoginController extends GetxController {
  late User userData;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getData()async{
    var userData = await Hive.openBox<User>('user');
    // userData.
  }
}
