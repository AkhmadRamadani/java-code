import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/cart_controller.dart';
import 'package:javacode/Modules/Features/Controllers/voucher_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/loading_components.dart';
import 'package:javacode/Modules/Features/Views/Components/voucher_card_components.dart';
import 'package:javacode/Modules/Features/Views/UI/voucher_detail_view.dart';
import 'package:shimmer/shimmer.dart';

class ChooseVoucherView extends GetView<VoucherController> {
  ChooseVoucherView({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherController>(
        init: VoucherController(),
        builder: (value) {
          return WillPopScope(
            onWillPop: () async {
              CartController cartController = Get.find();
              cartController.selectedVoucher = value.selectedVoucher;
              cartController.update();
              return true;
            },
            child: Scaffold(
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
                      Icons.airplane_ticket_outlined,
                      color: colorConst.secondaryColor,
                      size: 32,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Pilih Voucher",
                      style: TextStyle(
                        fontSize: 22,
                        color: colorConst.textColor,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              body: value.isLoading.isTrue
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              )),
                          itemCount: 4,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ListView.builder(
                            itemCount:
                                value.myVoucherResponse?.voucher?.length ?? 0,
                            itemBuilder: (context, index) {
                              return VoucherCardComponents(
                                onCheckFunction: () {
                                  value.setSelectedVoucher(index);
                                },
                                onImageFunction: () {
                                  value.getDetailVoucher(index);
                                  Get.to(VoucherDetailView(
                                    voucherController: value,
                                  ));
                                },
                                voucher:
                                    value.myVoucherResponse!.voucher![index],
                              );
                            },
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: colorConst.secondaryColor,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text:
                                                'Penggunaan voucher tidak dapat digabung dengan\n',
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    'discount employee reward program',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      colorConst.secondaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        CartController cartController =
                                            Get.find();
                                        cartController.selectedVoucher =
                                            value.selectedVoucher;
                                        cartController.update();
                                        Get.back();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: colorConst.secondaryColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Oke",
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
                        )
                      ],
                    ),
            ),
          );
        });
  }
}
