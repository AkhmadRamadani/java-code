import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';

class ButtonComponents extends StatelessWidget {
  ButtonComponents(
      {Key? key,
      this.buttonTitle,
      this.iconPath,
      this.buttonColor,
      this.textColor})
      : super(key: key);
  final String? buttonTitle;
  final String? iconPath;
  final Color? buttonColor;
  final Color? textColor;
  final ColorConst colorConst = ColorConst();
  final AssetsConst assetsConst = AssetsConst();
  @override
  Widget build(BuildContext context) {
    return iconPath != null
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: buttonColor ?? Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                        child: SvgPicture.asset(iconPath ??
                            assetsConst.svgPath + assetsConst.googleIcons),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    buttonTitle ?? "Title",
                    style: TextStyle(
                        fontSize: 16,
                        color: textColor ?? colorConst.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 44,
            decoration: BoxDecoration(
              color: buttonColor ?? colorConst.primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: Text(
              buttonTitle ?? "Title",
              style: TextStyle(
                fontSize: 16,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
