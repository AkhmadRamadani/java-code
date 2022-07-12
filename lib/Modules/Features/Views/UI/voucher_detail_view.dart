import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/cart_controller.dart';
import 'package:javacode/Modules/Features/Controllers/voucher_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/app_bar_components.dart';

class VoucherDetailView extends GetView<VoucherController> {
  VoucherDetailView({Key? key, required this.voucherController})
      : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  VoucherController voucherController;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherController>(
      init: voucherController,
      builder: (value) {
        return Scaffold(
          backgroundColor: colorConst.backgroundCardColor,
          appBar: AppBarComponents(
            title: 'Detail Voucher',
          ),
          body: SafeArea(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    value.detailVoucher!.infoVoucher ?? ""),
                              ),
                            )),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: constraints.maxHeight - 218),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 45,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.detailVoucher?.nama ?? "Nama Promo",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: colorConst.secondaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  HtmlWidget(
                                      value.detailVoucher?.catatan ?? ""),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            size: 22,
                                            color: colorConst.secondaryColor,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            "Valid Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                              color: colorConst.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${value.detailVoucher?.periodeMulai ?? ''} - ${value.detailVoucher?.periodeSelesai ?? ''}",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              CartController cartController = Get.find();
                              cartController.selectedVoucher =
                                  value.detailVoucher;
                              cartController.update();
                              Get.close(2);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: colorConst.secondaryColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Pakai Voucher",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
