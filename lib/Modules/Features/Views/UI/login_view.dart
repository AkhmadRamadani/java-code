import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/login_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (value) {
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.asset(
                          assetsConst.imagesPath + assetsConst.pattern1Image),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Image.asset(
                          assetsConst.imagesPath + assetsConst.javaCodeImage,
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Masuk untuk melanjutkan!",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Lorem.ipsum@gmal.com",
                              labelText: "Alamat Email",
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: colorConst.textColor,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          obscureText: value.isPasswordShowed.value,
                          decoration: InputDecoration(
                            hintText: "***********************",
                            labelText: "Kata Sandi",
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: colorConst.textColor,
                            ),
                            suffixIcon: value.isPasswordShowed.value
                                ? InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        height: 20,
                                        child: SvgPicture.asset(
                                            assetsConst.svgPath +
                                                assetsConst.unshowPass),
                                      ),
                                    ),
                                    onTap: () {
                                      loginController.unShowPassword();
                                    },
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      loginController.showPassword();
                                    },
                                    child: Icon(Icons.remove_red_eye_outlined)),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: (){
                            loginController.loginFunction("email@email.com", "password123");
                          },
                          child: ButtonComponents(
                            buttonTitle: "Masuk",
                          ),
                        ),
                        SizedBox(
                          height: 77,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(),
                              flex: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                "atau",
                                style: TextStyle(
                                  color: colorConst.greyTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(),
                              flex: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ButtonComponents(
                          iconPath:
                              assetsConst.svgPath + assetsConst.googleIcons,
                          buttonTitle: "Masuk Menggunakan Google",
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ButtonComponents(
                          iconPath:
                              assetsConst.svgPath + assetsConst.appleIcons,
                          buttonColor: colorConst.textColor,
                          textColor: Colors.white,
                          buttonTitle: "Masuk Menggunakan Apple",
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
