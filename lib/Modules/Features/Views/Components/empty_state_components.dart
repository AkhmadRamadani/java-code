import 'package:flutter/material.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';

class EmptyStateComponents extends StatelessWidget {
  EmptyStateComponents({Key? key, this.imageAsset, this.text})
      : super(key: key);
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  String? imageAsset;
  String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 156,
                        height: 156,
                        child: Image.asset(
                          imageAsset ??
                              assetsConst.imagesPath +
                                  assetsConst.historyKosongIconBlue,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        text ?? "Judul",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            assetsConst.imagesPath + assetsConst.pattern2Image,
          )
        ],
      ),
    );
  }
}
