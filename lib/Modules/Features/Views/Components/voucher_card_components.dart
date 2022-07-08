import 'package:flutter/material.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Models/my_voucher_response_model.dart';

class VoucherCardComponents extends StatelessWidget {
  VoucherCardComponents({
    Key? key,
    required this.voucher,
    required this.onCheckFunction,
    required this.onImageFunction,
  }) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  Function onCheckFunction;
  Function onImageFunction;
  Voucher voucher;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: colorConst.backgroundCardColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              onCheckFunction();
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(voucher.nama ?? ""),
                  voucher.isSelected!
                      ? Icon(
                          Icons.check_box_outlined,
                          color: colorConst.secondaryColor,
                        )
                      : Icon(
                          Icons.check_box_outline_blank_rounded,
                          color: colorConst.textColor,
                        ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onImageFunction();
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 175,
                decoration: BoxDecoration(
                    color: colorConst.backgroundImageColor,
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    voucher.infoVoucher ?? "",
                    fit: BoxFit.cover,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
