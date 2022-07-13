import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Models/menu_response_model.dart';

class MenuCardComponents extends StatelessWidget {
  MenuCardComponents({Key? key, required this.menu, required this.onPressed})
      : super(key: key);
  Menu menu;
  Function() onPressed;
  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(246, 246, 246, 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                          color: colorConst.backgroundImageColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: 65,
                        height: 65,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            menu.foto ??
                                "https://i.ibb.co/R9kJtny/1637916829.png",
                            fit: BoxFit.contain,
                            
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        menu.nama ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(46, 46, 46, 1),
                        ),
                      ),
                      Text(
                        "Rp ${menu.harga.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(0, 154, 173, 1),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        alignment: Alignment.topLeft,
                        child: TextField(
                          enabled: false,
                          style: TextStyle(
                              fontSize: 12.0, height: 2.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            prefixIconConstraints: BoxConstraints(maxWidth: 16),
                            hintText: 'Tambahkan catatan',
                            prefixIcon: Icon(
                              Icons.notes,
                              size: 12,
                              color: Color.fromRGBO(0, 154, 173, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   width: 20,
                      //   height: 20,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       width: 1,
                      //       color: Color.fromRGBO(0, 154, 173, 1),
                      //     ),
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: Icon(Icons.remove, size: 12, color: colorConst.secondaryColor,),
                      // ),
                      // SizedBox(width: 10),
                      Text("0"),
                      SizedBox(width: 12),
                      Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: colorConst.secondaryColor,
                            border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(0, 154, 173, 1),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 12,
                            color: Colors.white,
                          )),
                      SizedBox(width: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
