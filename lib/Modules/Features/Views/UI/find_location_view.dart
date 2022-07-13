import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/find_location_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';
import 'package:lottie/lottie.dart';

class FindLocationView extends GetView<FindLocationController> {
  FindLocationView({Key? key}) : super(key: key);

  Box<User> box = Hive.box<User>('user');
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FindLocationController>(
          init: FindLocationController(),
          builder: (value) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Image.asset(
                            assetsConst.imagesPath + assetsConst.pattern2Image),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "find_location".tr,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 48),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset(
                              assetsConst.imagesPath +
                                  assetsConst.mapAreaCircle,
                              width: 190,
                              height: 190,
                            ),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Lottie.asset(
                                      assetsConst.lottiesPath +
                                          assetsConst.loadingLocation,
                                      fit: BoxFit.contain),
                                ))
                          ],
                        ),
                        SizedBox(height: 48),
                        Text(
                          value.isLoading.isTrue
                              ? "Loading......."
                              : value.location?.street ?? "unresolved_location".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 48),
                        value.isLoading.isTrue
                            ? Container()
                            : value.location == null
                                ? GestureDetector(
                                    onTap: () {
                                      value.getLocation();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 64.0),
                                      child: ButtonComponents(
                                        buttonTitle: "recheck".tr,
                                      ),
                                    ),
                                  )
                                : Container()
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
