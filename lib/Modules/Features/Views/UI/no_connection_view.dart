import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';
import 'package:javacode/Modules/Features/Views/Components/loading_components.dart';
import 'package:javacode/Modules/GlobalControllers/main_controller.dart';

class NoConnection extends GetView<MainController> {
  NoConnection({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  final MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    // mainController.checkConnection();
    return Scaffold(
      body: GetBuilder<MainController>(
        init: MainController(),
        builder: (value) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          assetsConst.imagesPath +
                              assetsConst.noConnectionImage,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "No Connection!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Your internet is down, check the router, airplane mode or other connectivities",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            mainController.checkConnection();
                          },
                          child: ButtonComponents(
                            buttonTitle: "Reconnect",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // LoadingComponent()
              value.isLoading.isTrue ? LoadingComponent() : Container()
            ],
          );
        },
      ),
    );
  }
}
