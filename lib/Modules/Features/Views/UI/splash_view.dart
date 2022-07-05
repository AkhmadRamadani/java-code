import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Modules/Features/Views/UI/login_view.dart';
import 'package:javacode/Modules/Features/Views/UI/no_connection_view.dart';
import 'package:javacode/Modules/GlobalControllers/main_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(assetsConst.imagesPath + assetsConst.pattern1Image),
              Image.asset(assetsConst.imagesPath + assetsConst.javaCodeImage),
            ],
          ),
        ),
      ),
    );
  }
}
