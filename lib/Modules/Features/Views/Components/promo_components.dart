import 'package:flutter/material.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Models/promo_response_model.dart';

import 'package:intl/intl.dart';

class PromoComponents extends StatelessWidget {
  PromoComponents({Key? key, required this.data, this.detail = false})
      : super(key: key);
  Promo data;
  bool detail;
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();

  final formatCurrency = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: detail ? 180 : 160,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorConst.secondaryColor,
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: detail ? 180 : 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                data.type!.contains("voucher")
                    ? assetsConst.imagesPath + assetsConst.voucherImage
                    : assetsConst.imagesPath + assetsConst.diskonImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: detail ? 180 : 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorConst.gradientCardPromoColor.withOpacity(0.88),
                  colorConst.secondaryColor.withOpacity(0.88),
                ],
              ),
            ),
            child: data.type!.contains("diskon")
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Diskon",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            " ${data.diskon} %",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Colors.white,
                              fontSize: 48,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          data.nama ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Voucher",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        "Rp. ${formatCurrency.format(data.nominal)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.white,
                          fontSize: 38,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          data.nama ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
