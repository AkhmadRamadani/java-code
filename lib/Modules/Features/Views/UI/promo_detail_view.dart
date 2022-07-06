import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/promo_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/promo_components.dart';
import 'package:javacode/Modules/Models/promo_response_model.dart';

class PromoDetailView extends GetView<PromoController> {
  PromoDetailView({Key? key, required this.promo}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  Promo promo;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromoController>(
      init: PromoController(promo: promo),
      builder: (value) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              value.share();
            },
            child: Icon(Icons.share),
          ),
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
                    Icons.confirmation_num_rounded,
                    color: colorConst.secondaryColor,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Promo",
                    style: TextStyle(
                      fontSize: 22,
                      color: colorConst.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              )),
          body: SafeArea(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: PromoComponents(
                        data: promo,
                        detail: true,
                      ),
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight - 230),
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
                                "Nama Promo",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: colorConst.textColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                promo.nama ?? "Nama Promo",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: colorConst.secondaryColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.list_rounded,
                                    size: 22,
                                    color: colorConst.secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Syarat dan Ketentuan",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: colorConst.textColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          HtmlWidget(promo.syaratKetentuan ?? "")
                                        ],
                                      ),
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
              );
            }),
          ),
        );
      }
    );
  }
}
