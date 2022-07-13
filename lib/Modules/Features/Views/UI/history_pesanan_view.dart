import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/history_pesanan_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/empty_state_components.dart';
import 'package:javacode/Modules/Features/Views/Components/order_history_components.dart';
import 'package:javacode/Modules/Features/Views/Components/riwayat_order_components.dart';
import 'package:javacode/Modules/Features/Views/UI/pesanan_tracking_view.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Functions/common_functions.dart';
import 'package:shimmer/shimmer.dart';

class HistoryPesananView extends GetView<HistoryPesananController> {
  HistoryPesananView({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  final CommonFunctions commonFunctions = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryPesananController>(
        init: HistoryPesananController(),
        builder: (value) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              automaticallyImplyLeading: false,
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: TabBar(
                      controller: value.controller,
                      labelColor: colorConst.secondaryColor,
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      indicatorColor: colorConst.secondaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: colorConst.textColor,
                      tabs: [
                        Text("underway".tr),
                        Text("history".tr),
                      ],
                    )),
              ),
            ),
            body: TabBarView(
              controller: value.controller,
              children: [
                value.isLoading.isTrue
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
                    : value.order != null
                        ? value.order!.order!.length > 0
                            ? ListView.builder(
                                itemCount: value.order?.order?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(PesananTrackingView(
                                          id: value
                                              .order!.order![index].idOrder!));
                                    },
                                    child: OrderHistoryCardComponents(
                                        menuHistory:
                                            value.order!.order![index]),
                                  );
                                },
                              )
                            : EmptyStateComponents(
                                text: "empty_history".tr,
                              )
                        : EmptyStateComponents(
                            text: "empty_history".tr,
                          ),
                value.isLoading.isTrue
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
                    : SingleChildScrollView(
                        child: Container(
                          // width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: colorConst.secondaryColor),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        color: const Color.fromRGBO(
                                            246, 246, 246, 1),
                                      ),
                                      child: Row(
                                        children: [
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isDense: true,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              value: value.selectedDropdownItem,
                                              items: value.dropdownItems
                                                  .map((item) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  value: item,
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                // value.selectedDropdownItem =
                                                //     newValue!;
                                                value.filterData(newValue!);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        value.showMyDatePicker();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: colorConst.secondaryColor),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                          color: const Color.fromRGBO(
                                              246, 246, 246, 1),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${value.startDateString} - ${value.endDateString} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: const Color.fromRGBO(
                                                      170, 170, 170, 1)),
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8),
                                                child: Icon(
                                                  Icons.calendar_month,
                                                  color:
                                                      colorConst.secondaryColor,
                                                ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              value.listHistoryOrderFilterred.length > 0
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: value
                                          .listHistoryOrderFilterred.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(PesananTrackingView(
                                                id: value
                                                    .listHistoryOrderFilterred[
                                                        index]
                                                    .idOrder!));
                                          },
                                          child: RiwayatOrderComponents(
                                              pesanLagi: () {
                                                value.pesanLagiFunction(value
                                                        .listHistoryOrderFilterred[
                                                    index]);
                                              },
                                              menuHistory: value
                                                      .listHistoryOrderFilterred[
                                                  index]),
                                        );
                                      },
                                    )
                                  : EmptyStateComponents(
                                      text:
                                          "empty_history_order".tr,
                                    ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        });
  }

  Container _buildFilter(HistoryPesananController value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: colorConst.secondaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: const Color.fromRGBO(246, 246, 246, 1),
            ),
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isDense: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    value: value.selectedDropdownItem,
                    items: value.dropdownItems.map((item) {
                      return DropdownMenuItem(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      value.selectedDropdownItem = newValue!;
                      // value.filterData();
                    },
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              value.showMyDatePicker();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: colorConst.secondaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                color: const Color.fromRGBO(246, 246, 246, 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${value.startDateString} - ${value.endDateString} ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color.fromRGBO(170, 170, 170, 1)),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.calendar_month,
                        color: colorConst.secondaryColor,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
