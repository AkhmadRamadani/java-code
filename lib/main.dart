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
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AksesAdapter());
  await Hive.openBox<User>('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
