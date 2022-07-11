import 'package:flutter/material.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Functions/common_functions.dart';

class OrderHistoryCardComponents extends StatelessWidget {
  OrderHistoryCardComponents({Key? key, required this.menuHistory})
      : super(key: key);
  Order menuHistory;

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  final CommonFunctions commonFunctions = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    return buildItemOrderHistory(context, menuHistory);
  }

  InkWell buildItemOrderHistory(BuildContext context, Order menuHistory) {
    return InkWell(
      onTap: () {
        // Navigation.intentWithData(
        //   DetailOrderPage.routeName,
        //   menuHistory.idOrder,
        // );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
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
                                  .format(menuHistory.totalBayar).toString(),
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
                  ],
                ),
              ),
            ),
          ],
        ),
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
      teks = 'Dalam Antrian';
    } else if (menuHistory.status == 1) {
      icon = Icons.access_time;
      color = const Color.fromRGBO(255, 172, 1, 1);
      teks = 'Sedang Disiapkan';
    } else if (menuHistory.status == 2) {
      icon = Icons.check;
      color = const Color.fromRGBO(0, 156, 72, 1);
      teks = 'Bisa Diambil';
    } else if (menuHistory.status == 3) {
      icon = Icons.check;
      color = const Color.fromRGBO(0, 156, 72, 1);
      teks = 'Selesai';
    } else {
      icon = Icons.close;
      color = const Color.fromRGBO(230, 33, 41, 1);
      teks = 'Dibatalkan';
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
