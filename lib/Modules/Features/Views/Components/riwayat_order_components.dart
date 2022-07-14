import 'package:flutter/material.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Functions/common_functions.dart';
import 'package:get/get.dart';

class RiwayatOrderComponents extends StatelessWidget {
  RiwayatOrderComponents(
      {Key? key, required this.menuHistory, required this.pesanLagi})
      : super(key: key);
  Order menuHistory;
  Function pesanLagi;
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  final CommonFunctions commonFunctions = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    return buildItemOrderHistory(context, menuHistory);
  }

  Widget buildItemOrderHistory(BuildContext context, Order menuHistory) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: colorConst.backgroundCardColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.grey.withAlpha(70),
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(menuHistory.menu![0].foto!),
                ),
                color: colorConst.backgroundImageColor),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusOrder(menuHistory),
                      Text(
                        commonFunctions.convertDate(
                            menuHistory.tanggal.toString(), 'dd MMM yyyy'),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color.fromRGBO(170, 170, 170, 1),
                        ),
                      )
                    ],
                  ),
                  Text(
                    commonFunctions.getListMenuName(menuHistory.menu!),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Rp." +
                            commonFunctions.formatCurrency
                                .format(menuHistory.totalBayar)
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: colorConst.secondaryColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: Text(
                          "${menuHistory.menu?.length ?? 0} menu",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: const Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      menuHistory.status == 3
                          ? Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: colorConst.secondaryColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    "give_rating".tr,
                                    style: TextStyle(
                                      color: colorConst.secondaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                              ],
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          pesanLagi();
                        },
                        child: Container(
                          width: 90,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: colorConst.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(50),
                            color: colorConst.secondaryColor,
                          ),
                          child: Text(
                            "order_again".tr,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
    );
  }

  Row _buildStatusOrder(Order menuHistory) {
    IconData icon;
    String teks;
    Color color;
    if (menuHistory.status == 0) {
      icon = Icons.access_time;
      color = const Color.fromRGBO(255, 172, 1, 1);
      teks = "in_queue".tr;
    } else if (menuHistory.status == 1) {
      icon = Icons.access_time;
      color = const Color.fromRGBO(255, 172, 1, 1);
      teks = 'prepared'.tr;
    } else if (menuHistory.status == 2) {
      icon = Icons.check;
      color = const Color.fromRGBO(0, 156, 72, 1);
      teks = 'already_to_pick'.tr;
    } else if (menuHistory.status == 3) {
      icon = Icons.check;
      color = const Color.fromRGBO(0, 156, 72, 1);
      teks = 'done'.tr;
    } else {
      icon = Icons.close;
      color = const Color.fromRGBO(230, 33, 41, 1);
      teks = 'canceled'.tr;
    }
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: Text(
            teks,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
