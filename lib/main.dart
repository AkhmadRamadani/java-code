import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  await Hive.openBox<OrderHive>('order');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashView(),
    );
  }
}
