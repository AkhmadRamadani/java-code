import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/cart_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';
import 'package:javacode/Modules/Features/Views/Components/fingerprint_dialog_components.dart';
import 'package:javacode/Modules/Features/Views/Components/loading_components.dart';
import 'package:javacode/Modules/Features/Views/Components/menu_card_components.dart';

import 'package:intl/intl.dart';
import 'package:javacode/Modules/Features/Views/UI/choose_voucher_view.dart';
import 'package:javacode/Modules/Features/Views/UI/edit_menu_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CartView extends GetView<CartController> {
  CartView({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  final formatCurrency = NumberFormat.decimalPattern();
  // CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (value) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  leading: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: colorConst.textColor,
                  ),
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.notifications_none_rounded,
                        color: colorConst.secondaryColor,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Pesanan",
                        style: TextStyle(
                          fontSize: 22,
                          color: colorConst.textColor,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2 +
                            (value.selectedVoucher != null ? 60 : 0),
                        child: ListView.builder(
                          itemCount: value.orderBox.values.first.menu!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(EditMenuView(index: index));
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0, right: 18.0, left: 18.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromRGBO(246, 246, 246, 1)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 75,
                                              height: 75,
                                              decoration: BoxDecoration(
                                                  color: colorConst
                                                      .backgroundImageColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Container(
                                                width: 65,
                                                height: 65,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    value.orderBox.values.first
                                                        .menu![index].gambar,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                value.orderBox.values.first
                                                    .menu![index].nama,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: Color.fromRGBO(
                                                      46, 46, 46, 1),
                                                ),
                                              ),
                                              Text(
                                                "Rp ${value.orderBox.values.first.menu![index].harga.toString()}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                  color:
                                                      colorConst.secondaryColor,
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 30,
                                                alignment: Alignment.topLeft,
                                                child: TextField(
                                                  enabled: false,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      height: 2.0,
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    isDense: true,
                                                    prefixIconConstraints:
                                                        BoxConstraints(
                                                            maxWidth: 16),
                                                    hintText: value
                                                        .orderBox
                                                        .values
                                                        .first
                                                        .menu![index]
                                                        .catatan,
                                                    prefixIcon: Icon(
                                                      Icons.notes,
                                                      size: 12,
                                                      color: colorConst
                                                          .secondaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: colorConst
                                                          .secondaryColor,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 12,
                                                    color: colorConst
                                                        .secondaryColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(value.orderBox.values.first
                                                  .menu![index].jumlah
                                                  .toString()),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: colorConst
                                                          .secondaryColor,
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            0, 154, 173, 1),
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 12,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(246, 246, 246, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Pesanan (" +
                                              value.orderBox.values.first.menu!
                                                  .length
                                                  .toString() +
                                              " menu) : ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Rp " +
                                              formatCurrency
                                                  .format(value.orderBox.values
                                                      .first.totalBayar)
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: colorConst.secondaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  value.selectedVoucher != null
                                      ? Container()
                                      : Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25.0),
                                              child: Divider(),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.defaultDialog(
                                                  title: "Info Diskon",
                                                  titlePadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 24),
                                                  titleStyle: TextStyle(
                                                    color: colorConst
                                                        .secondaryColor,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textCancel: "Oke",
                                                  cancel: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 80,
                                                      vertical: 12,
                                                    ),
                                                    child: ButtonComponents(
                                                        buttonTitle: "Oke"),
                                                  ),
                                                  content: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 25),
                                                    height: (40 *
                                                            value
                                                                .diskonResponse!
                                                                .diskon!
                                                                .length)
                                                        .toDouble(),
                                                    child: ListView.builder(
                                                      itemCount: value
                                                          .diskonResponse
                                                          ?.diskon
                                                          ?.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              value
                                                                      .diskonResponse
                                                                      ?.diskon?[
                                                                          index]
                                                                      .nama ??
                                                                  "",
                                                            ),
                                                            Text(
                                                              "${value.diskonResponse?.diskon?[index].diskon.toString() ?? "0"} %",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25.0,
                                                        vertical: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .discount_outlined,
                                                          size: 28,
                                                          color: colorConst
                                                              .secondaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "Diskon",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Rp " +
                                                          value
                                                              .getDiskonAmount()
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: colorConst
                                                              .dangerColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Divider(),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(ChooseVoucherView());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.airplane_ticket_outlined,
                                                size: 28,
                                                color:
                                                    colorConst.secondaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Voucher",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          value.selectedVoucher != null
                                              ? Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "Rp " +
                                                              value
                                                                  .selectedVoucher!
                                                                  .nominal
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: colorConst
                                                                  .dangerColor),
                                                        ),
                                                        Text(value
                                                                .selectedVoucher!
                                                                .nama ??
                                                            "")
                                                      ],
                                                    ),
                                                    Icon(Icons
                                                        .chevron_right_rounded)
                                                  ],
                                                )
                                              : Text("Input Voucher >"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Divider(),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.payment_outlined,
                                                size: 28,
                                                color:
                                                    colorConst.secondaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Pembayaran",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text("Pay later"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.shopping_basket_outlined,
                                          size: 28,
                                          color: colorConst.secondaryColor,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total Pembayaran",
                                            ),
                                            value.selectedVoucher != null
                                                ? Text(
                                                    "Rp " +
                                                        formatCurrency
                                                            .format(value
                                                                            .orderBox
                                                                            .values
                                                                            .first
                                                                            .totalBayar! -
                                                                        value
                                                                            .selectedVoucher!
                                                                            .nominal! <
                                                                    0
                                                                ? 0
                                                                : value
                                                                        .orderBox
                                                                        .values
                                                                        .first
                                                                        .totalBayar! -
                                                                    value
                                                                        .selectedVoucher!
                                                                        .nominal!)
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: colorConst
                                                          .secondaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                : Text(
                                                    "Rp " +
                                                        formatCurrency
                                                            .format(value
                                                                        .orderBox
                                                                        .values
                                                                        .first
                                                                        .totalBayar! <
                                                                    10000
                                                                ? value
                                                                    .orderBox
                                                                    .values
                                                                    .first
                                                                    .totalBayar
                                                                : value
                                                                        .orderBox
                                                                        .values
                                                                        .first
                                                                        .totalBayar! -
                                                                    value
                                                                        .getDiskonAmount())
                                                            .toString(),
                                                    style: TextStyle(
                                                      color: colorConst
                                                          .secondaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialogIdentify(context, value);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: colorConst.secondaryColor,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Pesan Sekarang",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              value.isLoading.isTrue ? LoadingComponent() : Container()
            ],
          );
        });
  }

  showDialogVerifyWithPin(CartController value) {
    return showDialog(
      context: Get.overlayContext!,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          content: Container(
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
                onCompleted: (v) async {
                  await value.checkPin();
                  if (value.isSuccess.isTrue) {
                    showOrderSuccessDialog();
                  }
                },
                onChanged: (String data) {
                  // value.pinController.text = data;
                },
              ),
            ]),
          ),
        );
      },
    );
  }

  showDialogIdentify(BuildContext context, CartController value) {
    // Get.delete<CartController>();
    return showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return AlertDialog(
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
                  // Navigator.pop(context);
                  // Get.delete<CartController>();
                  Future.delayed(Duration.zero, () async {
                    // Navigator.pop(context);
                    showDialogVerifyWithPin(value);

                    // await showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return showDialogVerifyWithPin(value);
                    //   },
                    // );
                  });
                  // SchedulerBinding.instance.addPostFrameCallback((_) {
                  //   showDialogVerifyWithPin(value);
                  // });
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
        );
      },
    );
  }

  Future<void> showModalVoucher(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (contextSheet) {
        return StatefulBuilder(builder: (builder, myState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2.3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.airplane_ticket_outlined,
                          size: 28,
                          color: colorConst.secondaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Punya Kode Voucher?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Masukkan kode voucher disini",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: colorConst.secondaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Validasi Voucher",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void showOrderSuccessDialog() {
    AlertDialog orderSuccessDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16),
            child:
                Image.asset(assetsConst.imagesPath + assetsConst.orderSukses),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Text(
              'Pesanan Sedang Disiapkan',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
                color: const Color.fromRGBO(30, 30, 30, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              'Kamu dapat melacak pesananmu di fitur Pesanan',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: const Color.fromRGBO(46, 46, 46, 0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                Get.close(2);
              },
              child: Text(
                'Oke',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
                primary: colorConst.secondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(40),
                side: const BorderSide(
                  color: Color.fromARGB(255, 0, 113, 127),
                  width: 1,
                ),
              ),
            ),
          )
        ],
      ),
    );

    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return orderSuccessDialog;
      },
    );
  }
}
