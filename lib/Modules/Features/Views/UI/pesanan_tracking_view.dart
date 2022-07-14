import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/detail_pesanan_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/app_bar_components.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';
import 'package:javacode/Modules/Features/Views/UI/main_view.dart';
import 'package:javacode/Utils/Functions/common_functions.dart';
import 'package:shimmer/shimmer.dart';

class PesananTrackingView extends GetView<DetailPesananController> {
  PesananTrackingView({Key? key, required this.id, this.fromOrder = true})
      : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  final CommonFunctions commonFunctions = CommonFunctions();
  int id;
  bool fromOrder;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailPesananController>(
        init: DetailPesananController(id_order: id),
        builder: (value) {
          return WillPopScope(
            onWillPop: () async {
              if (fromOrder) {
                Get.back();
              } else {
                Get.offAll(MainView());
              }
              return true;
            },
            child: Scaffold(
              appBar: AppBarComponents(
                icon: Icons.notifications_none_rounded,
                backPressed: () {
                  if (fromOrder) {
                    Get.back();
                  } else {
                    Get.offAll(MainView());
                  }
                },
                title: 'order'.tr,
              ),
              body: value.isLoading.isTrue
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(itemBuilder: (context, index) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            margin: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)));
                      }),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView.builder(
                              itemCount: value.orderDetailResponse?.dataOrder
                                      ?.detail?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Get.to(EditMenuView(index: index));
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, right: 18.0, left: 18.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromRGBO(
                                                246, 246, 246, 1)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        value
                                                                .orderDetailResponse
                                                                ?.dataOrder
                                                                ?.detail?[index]
                                                                .foto ??
                                                            "",
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
                                                    value
                                                            .orderDetailResponse
                                                            ?.dataOrder
                                                            ?.detail?[index]
                                                            .nama ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: Color.fromRGBO(
                                                          46, 46, 46, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rp ${value.orderDetailResponse?.dataOrder?.detail![index].harga.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: colorConst
                                                          .secondaryColor,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 30,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: TextField(
                                                      enabled: false,
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          height: 2.0,
                                                          color: Colors.black),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        isDense: true,
                                                        prefixIconConstraints:
                                                            BoxConstraints(
                                                                maxWidth: 16),
                                                        hintText: value
                                                            .orderDetailResponse
                                                            ?.dataOrder
                                                            ?.detail?[index]
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 10),
                                                  Text(
                                                    (value
                                                                .orderDetailResponse
                                                                ?.dataOrder
                                                                ?.detail?[index]
                                                                .jumlah ??
                                                            0)
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: colorConst
                                                            .textColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18),
                                                  ),
                                                  SizedBox(width: 10),
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
                                              "total_order".tr +
                                                  "(" +
                                                  (value
                                                              .orderDetailResponse
                                                              ?.dataOrder
                                                              ?.detail
                                                              ?.length ??
                                                          0)
                                                      .toString() +
                                                  " menu) : ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Rp " +
                                                  commonFunctions.formatCurrency
                                                      .format(value
                                                              .orderDetailResponse
                                                              ?.dataOrder
                                                              ?.order
                                                              ?.totalBayar ??
                                                          0)
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: colorConst
                                                      .secondaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value.orderDetailResponse?.dataOrder
                                                  ?.order?.idVoucher !=
                                              0
                                          ? Container()
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 25.0),
                                                  child: Divider(),
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25.0,
                                                        vertical: 12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                              "discount".tr,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "Rp " +
                                                              (value
                                                                          .orderDetailResponse
                                                                          ?.dataOrder
                                                                          ?.order
                                                                          ?.potongan ??
                                                                      0)
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: colorConst
                                                                  .dangerColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      value.orderDetailResponse?.dataOrder
                                                  ?.order?.idVoucher ==
                                              0
                                          ? Container()
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 25.0),
                                                  child: Divider(),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.to(ChooseVoucherView());
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25.0,
                                                        vertical: 12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .airplane_ticket_outlined,
                                                              size: 28,
                                                              color: colorConst
                                                                  .secondaryColor,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Voucher",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        value
                                                                    .orderDetailResponse
                                                                    ?.dataOrder
                                                                    ?.order
                                                                    ?.namaVoucher !=
                                                                null
                                                            ? Row(
                                                                children: [
                                                                  Text(value
                                                                          .orderDetailResponse
                                                                          ?.dataOrder
                                                                          ?.order
                                                                          ?.namaVoucher ??
                                                                      ""),
                                                                  Icon(Icons
                                                                      .chevron_right_rounded)
                                                                ],
                                                              )
                                                            : Text(
                                                                "Input Voucher >"),
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
                                                    color: colorConst
                                                        .secondaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "payment".tr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25.0),
                                            child: Divider(),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(ChooseVoucherView());
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
                                                      Text(
                                                        "total_payment".tr,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Rp. " +
                                                        commonFunctions
                                                            .formatCurrency
                                                            .format(value
                                                                    .orderDetailResponse
                                                                    ?.dataOrder
                                                                    ?.order
                                                                    ?.totalBayar ??
                                                                0)
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: colorConst
                                                          .secondaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25.0),
                                            child: Divider(),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(ChooseVoucherView());
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25.0,
                                                      vertical: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "order_is_prepared".tr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 24,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            value.orderDetailResponse!.dataOrder!.order!
                                                                            .status! >=
                                                                        1 &&
                                                                    value
                                                                            .orderDetailResponse!
                                                                            .dataOrder!
                                                                            .order!
                                                                            .status! <
                                                                        4
                                                                ? Icon(
                                                                    Icons
                                                                        .check_circle_rounded,
                                                                    color: colorConst
                                                                        .secondaryColor,
                                                                    size: 24,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .circle,
                                                                    color: colorConst
                                                                        .textColor
                                                                        .withOpacity(
                                                                            0.2),
                                                                    size: 24,
                                                                  ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              "order_is_accepted"
                                                                  .tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Divider(
                                                            thickness: 3,
                                                            color: value
                                                                            .orderDetailResponse!
                                                                            .dataOrder!
                                                                            .order!
                                                                            .status! >=
                                                                        2 &&
                                                                    value
                                                                            .orderDetailResponse!
                                                                            .dataOrder!
                                                                            .order!
                                                                            .status! <
                                                                        4
                                                                ? colorConst
                                                                    .secondaryColor
                                                                : null),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            value.orderDetailResponse!.dataOrder!.order!
                                                                            .status! >=
                                                                        2 &&
                                                                    value
                                                                            .orderDetailResponse!
                                                                            .dataOrder!
                                                                            .order!
                                                                            .status! <
                                                                        4
                                                                ? Icon(
                                                                    Icons
                                                                        .check_circle_rounded,
                                                                    color: colorConst
                                                                        .secondaryColor,
                                                                    size: 24,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .circle,
                                                                    color: colorConst
                                                                        .textColor
                                                                        .withOpacity(
                                                                            0.2),
                                                                    size: 24,
                                                                  ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              "you_can_take_it"
                                                                  .tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Divider(
                                                            thickness: 3,
                                                            color: value
                                                                        .orderDetailResponse
                                                                        ?.dataOrder
                                                                        ?.order
                                                                        ?.status ==
                                                                    3
                                                                ? colorConst
                                                                    .secondaryColor
                                                                : null),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            value
                                                                        .orderDetailResponse
                                                                        ?.dataOrder
                                                                        ?.order
                                                                        ?.status ==
                                                                    3
                                                                ? Icon(
                                                                    Icons
                                                                        .check_circle_rounded,
                                                                    color: colorConst
                                                                        .secondaryColor,
                                                                    size: 24,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .circle,
                                                                    color: colorConst
                                                                        .textColor
                                                                        .withOpacity(
                                                                            0.2),
                                                                    size: 24,
                                                                  ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              "order_is_done"
                                                                  .tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
          );
        });
  }
}
