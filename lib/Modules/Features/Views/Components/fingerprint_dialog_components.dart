import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/cart_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/pin_input_dialog_components.dart';

class FingerprintDialog extends GetView<CartController> {
  FingerprintDialog({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (value) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            height: MediaQuery.of(context).size.width - 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(25),
            child: Column(children: [
              Text(
                "Verifikasi Pesanan",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Finger Print",
              ),
              SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  value.authenticateWithBiometrics();
                },
                child: Icon(
                  Icons.fingerprint,
                  color: colorConst.secondaryColor,
                  size: 142,
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(Get.overlayContext!, rootNavigator: true)
                  //     .pop(Get.overlayContext!);
                  Navigator.pop(context);
                  Get.delete<CartController>();

                  Future.delayed(Duration.zero, () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PinInputDialog();
                      },
                    );
                  });
                  // WidgetsBinding.instance.addPostFrameCallback((_) {

                  // });

                  // Navigator.pop(context);
                },
                child: Text(
                  "Verifikasi Menggunakan PIN",
                  style: TextStyle(
                    color: colorConst.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
