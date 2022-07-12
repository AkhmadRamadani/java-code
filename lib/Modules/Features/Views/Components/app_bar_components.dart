import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';

class AppBarComponents extends StatelessWidget implements PreferredSizeWidget {
  AppBarComponents({Key? key, this.title, this.icon, this.backPressed}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  String? title;
  IconData? icon;
  Function? backPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      leading: InkWell(
        onTap: () {
          backPressed != null ? backPressed!() : Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: colorConst.textColor,
        ),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Row(
                  children: [
                    Icon(
                      icon,
                      color: colorConst.secondaryColor,
                      size: 32,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                )
              : Container(),
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: 22,
              color: colorConst.textColor,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
