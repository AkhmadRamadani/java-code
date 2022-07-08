import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/edit_menu_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';
import 'package:shimmer/shimmer.dart';

class EditMenuView extends GetView<EditMenuController> {
  EditMenuView({Key? key, required this.index}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditMenuController>(
        init: EditMenuController(index: index),
        builder: (value) {
          return Scaffold(
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
                  Text(
                    "Detail Menu",
                    style: TextStyle(
                      fontSize: 22,
                      color: colorConst.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            body: SafeArea(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return value.isLoading.isTrue
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Container(
                                width: 240,
                                height: 180,
                                color: Colors.white,
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight - 230),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Container(
                                width: 240,
                                height: 180,
                                child: Image.network(
                                    value.menuDetailResponse?.data?.menu
                                            ?.foto ??
                                        "https://i.ibb.co/R9kJtny/1637916829.png",
                                    fit: BoxFit.contain),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight - 230),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.menuDetailResponse?.data?.menu
                                                    ?.nama ??
                                                "Judul Menu",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24,
                                              color: colorConst.secondaryColor,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  value.subtractAmount();
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          0, 154, 173, 1),
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 12,
                                                    color: colorConst
                                                        .secondaryColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(value.menuHive.jumlah
                                                  .toString()),
                                              SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  value.addAmount();
                                                },
                                                child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: colorConst
                                                          .secondaryColor,
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            0, 154, 173, 1),
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 12,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        value.menuDetailResponse?.data?.menu
                                                ?.deskripsi ??
                                            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 18,
                                                height: 18,
                                                child: Image.asset(
                                                  assetsConst.imagesPath +
                                                      assetsConst.hargaIconBlue,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "Harga",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Rp. ${value.menuHive.harga ?? "0.00"}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Color.fromRGBO(
                                                  0, 154, 173, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      value.menuDetailResponse!.data!.level!
                                              .isNotEmpty
                                          ? Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showLevelBottomSheet(
                                                        context, value);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 18,
                                                            height: 18,
                                                            child: Image.asset(
                                                              assetsConst
                                                                      .imagesPath +
                                                                  assetsConst
                                                                      .levelIconBlue,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            "Level",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            value.menuHive
                                                                .keteranganLevel,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: colorConst
                                                                    .textColor),
                                                          ),
                                                          SizedBox(
                                                            width: 12,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              size: 18,
                                                              color: colorConst
                                                                  .textColor)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Divider(),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      value.menuDetailResponse!.data!.topping!
                                              .isNotEmpty
                                          ? Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showTopingBottomSheet(
                                                        context, value);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 18,
                                                            height: 18,
                                                            child: Image.asset(
                                                              assetsConst
                                                                      .imagesPath +
                                                                  assetsConst
                                                                      .topingIconBlue,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            "Toping",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            value.getToppingName(value
                                                                .menuHive
                                                                .toppingDetail!
                                                                .map((e) => e
                                                                    .keterangan)
                                                                .toList()),
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: colorConst
                                                                    .textColor),
                                                          ),
                                                          SizedBox(
                                                            width: 12,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              size: 18,
                                                              color: colorConst
                                                                  .textColor)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Divider(),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          showNoteBottomSheet(context, value);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 18,
                                                  height: 18,
                                                  child: Image.asset(
                                                    assetsConst.imagesPath +
                                                        assetsConst
                                                            .noteIconBlue,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "Catatan",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  value.menuHive.catatan
                                                          .isNotEmpty
                                                      ? value.menuHive.catatan
                                                                  .length >
                                                              20
                                                          ? value.menuHive
                                                                  .catatan
                                                                  .substring(
                                                                      0, 17) +
                                                              "..."
                                                          : value
                                                              .menuHive.catatan
                                                      : "",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color:
                                                          colorConst.textColor),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Icon(
                                                    Icons.chevron_right_rounded,
                                                    size: 18,
                                                    color: colorConst.textColor)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          value.simpanEditMenu();
                                        },
                                        child: ButtonComponents(
                                          buttonTitle: "Simpan",
                                        ),
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
        });
  }
  
  PersistentBottomSheetController showTopingBottomSheet(
      BuildContext context, EditMenuController menu) {
    return showBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (_) {
          return GetBuilder<EditMenuController>(
              init: menu,
              builder: (menu) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            width: 100,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:
                                    colorConst.greyTextColor.withOpacity(0.5)),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Pilih Toping",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: colorConst.textColor,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 25,
                          child: ListView.builder(
                            itemCount:
                                menu.menuDetailResponse?.data?.topping?.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  menu.addTopping(
                                      menu.menuDetailResponse!.data!
                                          .topping![index],
                                      index);
                                },
                                child: levelItem(
                                    text: menu.menuDetailResponse?.data
                                            ?.topping?[index].keterangan ??
                                        "none",
                                    selected: menu.menuDetailResponse?.data
                                            ?.topping?[index].isSelected ??
                                        false),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  PersistentBottomSheetController showLevelBottomSheet(
      BuildContext context, EditMenuController menu) {
    return showBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (_) {
          return GetBuilder<EditMenuController>(
              init: menu,
              builder: (menu) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            width: 100,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:
                                    colorConst.greyTextColor.withOpacity(0.5)),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Pilih Level",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: colorConst.textColor,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 25,
                          child: ListView.builder(
                            itemCount:
                                menu.menuDetailResponse?.data?.level?.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  menu.chooseLevel(
                                      menu.menuDetailResponse!.data!
                                          .level![index],
                                      index);
                                },
                                child: levelItem(
                                    text: menu.menuDetailResponse?.data
                                            ?.level?[index].keterangan ??
                                        "none",
                                    selected: menu.menuDetailResponse?.data
                                            ?.level?[index].idDetail ==
                                        menu.menuHive.level),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Container levelItem({required String text, required bool selected}) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
        color: selected ? colorConst.secondaryColor : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        border: Border.all(
            color: selected ? Colors.white : colorConst.secondaryColor),
      ),
      margin: const EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: selected ? Colors.white : Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: selected
                ? const Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.white,
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  PersistentBottomSheetController showNoteBottomSheet(
      BuildContext context, EditMenuController menu) {
    return showBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (_) {
          return GetBuilder<EditMenuController>(
              init: menu,
              builder: (menu) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            width: 100,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:
                                    colorConst.greyTextColor.withOpacity(0.5)),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Buat Catatan",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: colorConst.textColor,
                          ),
                        ),
                        TextField(
                          maxLines: 1,
                          controller: menu.catatanController,
                          onChanged: (value) {
                            menu.onChangedCatatan(value);
                          },
                          autofocus: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                          decoration: InputDecoration(
                              hintText: "Jangan dibuat pedas, dll",
                              suffixIcon: Icon(Icons.check_circle_rounded)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.bottomRight,
                            child: Text("${menu.menuHive.catatan.length}/100")),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
