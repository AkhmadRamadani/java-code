import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:javacode/Config/Localization/locale_strings.dart';
import 'package:javacode/Modules/Features/Views/UI/login_view.dart';
import 'package:javacode/Modules/Features/Views/UI/no_connection_view.dart';
import 'package:javacode/Modules/Features/Views/UI/splash_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Models/Hive/akses_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/menu_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/topping_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AksesAdapter());
  Hive.registerAdapter(OrderHiveAdapter());
  Hive.registerAdapter(ToppingAdapter());
  Hive.registerAdapter(MenuHiveAdapter());

  await Hive.openBox<User>('user');
  await Hive.openBox('selected_language');
  await Hive.openBox<OrderHive>('order');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  var languageBox = Hive.box("selected_language");
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    selectedLanguage = languageBox.get("country_id");
  
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: selectedLanguage != null
          ? Locale(selectedLanguage!)
          : Get.deviceLocale,
      translations: LocaleString(),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashView(),
    );
  }
}
