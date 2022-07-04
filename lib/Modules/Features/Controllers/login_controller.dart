import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:javacode/Modules/Features/Views/UI/find_location_view.dart';

class LoginController extends GetxController {
  RxBool isPasswordShowed = false.obs;

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
    if(password.length < 8){
      Get.snackbar("Password Invalid", "Panjang password minimal 8 karakter");
      return;
    }
      Get.to(FindLocationView());
    
  }
}
