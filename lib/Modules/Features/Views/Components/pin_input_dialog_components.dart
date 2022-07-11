import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Features/Controllers/cart_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinInputDialog extends GetView<CartController> {
  const PinInputDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        content: GetBuilder<CartController>(
            init: CartController(),
            builder: (value) {
              return Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: Column(children: [
                  Text(
                    "Verifikasi Pesanan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Masukkan Kode Pin",
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  PinCodeTextField(
                    controller: value.pinController,
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    autoFocus: true,
                    obscuringCharacter: '*',
                    keyboardType: TextInputType.number,
                    errorAnimationController: value.errorController,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 35,
                      fieldWidth: 35,
                    ),
                    onCompleted: (v) {
                      value.checkPin();
                    },
                    onChanged: (String data) {
                      // value.pinController.text = data;
                    },
                  ),
                ]),
              );
            }),
      ),
    );
  }
}
