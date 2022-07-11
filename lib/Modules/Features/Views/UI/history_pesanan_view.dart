import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/history_pesanan_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/order_history_components.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Functions/common_functions.dart';

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
                        Text("Sedang Berjalan"),
                        Text("Riwayat"),
                      ],
                    )),
              ),
            ),
            body: TabBarView(
              controller: value.controller,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ListView.builder(
                    itemCount: value.order?.order?.length ?? 0,
                    itemBuilder: (context, index) {
                      return OrderHistoryCardComponents(
                          menuHistory: value.order!.order![index]);
                    },
                  ),
                ),
                Text("B"),
              ],
            ),
          );
        });
  }
}
