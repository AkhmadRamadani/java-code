import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/beranda_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/menu_card_components.dart';
import 'package:javacode/Modules/Features/Views/Components/promo_components.dart';
import 'package:javacode/Modules/Features/Views/UI/promo_detail_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull_to_refresh;
import 'package:shimmer/shimmer.dart';

class BerandaView extends GetView<BerandaController> {
  BerandaView({Key? key}) : super(key: key);

  final AssetsConst assetsConst = AssetsConst();
  final ColorConst colorConst = ColorConst();
  BerandaController berandaController = BerandaController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BerandaController>(
        init: BerandaController(),
        builder: (value) {
          return Scaffold(
            // key: berandaController.scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              automaticallyImplyLeading: false,
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: colorConst.secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: TextField(
                    controller: value.searchController,
                    onChanged: (data) => value.onSearchTextChanged(data),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                            size: 26, color: colorConst.secondaryColor),
                        border: InputBorder.none,
                        hintText: "Pencarian",
                        hintStyle: TextStyle(
                          color: colorConst.greyTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ),
            ),
            body: pull_to_refresh.SmartRefresher(
              controller: value.refreshController,
              onRefresh: value.onRefresh,
              child: value.isLoading.isTrue
                  ? shimmerLoading(context)
                  : value.searchController.text.isEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.confirmation_num_rounded,
                                      color: colorConst.secondaryColor,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "Promo yang tersedia",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 160,
                                  autoPlay: true,
                                  disableCenter: true,
                                ),
                                items: value.promoResponse.promo?.map((data) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                          onTap: () {
                                            Get.to(
                                                PromoDetailView(promo: data));
                                          },
                                          child: PromoComponents(data: data));
                                    },
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TabBar(
                                controller: value.controller,
                                padding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.zero,
                                isScrollable: true, // Required
                                labelStyle: TextStyle(color: Colors.white),
                                unselectedLabelColor:
                                    Colors.white, // Other tabs color
                                labelPadding: EdgeInsets.symmetric(
                                    horizontal: 12), // Space between tabs
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        20), // Creates border
                                    color: Colors.transparent),
                                onTap: value.handleTabSelection,
                                tabs: [
                                  Container(
                                    height: 40.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: value.controller.index == 0
                                          ? colorConst.textColor
                                          : colorConst.secondaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.list_rounded),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Center(child: Text("Semua Menu")),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: value.controller.index == 1
                                          ? colorConst.textColor
                                          : colorConst.secondaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.fastfood_outlined),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Center(child: Text("Makanan")),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: value.controller.index == 2
                                          ? colorConst.textColor
                                          : colorConst.secondaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.local_drink_outlined),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Center(child: Text("Minuman")),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: value.controller.index == 3
                                          ? colorConst.textColor
                                          : colorConst.secondaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.fastfood_outlined),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Center(child: Text("Snack")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width,
                                child: TabBarView(
                                    controller: value.controller,
                                    children: value.tabs.map((String e) {
                                      if (value.controller.index == 1) {
                                        return ListView.builder(
                                          itemCount: value.makananList.length,  
                                          itemBuilder: (context, index) {
                                            return MenuCardComponents(
                                                menu:
                                                    value.makananList[index]!);
                                          },
                                        );
                                      } else if (value.controller.index == 2) {
                                        return ListView.builder(
                                          itemCount: value.minumanList.length,  
                                          itemBuilder: (context, index) {
                                            return MenuCardComponents(
                                                menu:
                                                    value.minumanList[index]!);
                                          },
                                        );
                                      } else if (value.controller.index == 3) {
                                        return ListView.builder(
                                          itemCount: value.snackList.length,  
                                          itemBuilder: (context, index) {
                                            return MenuCardComponents(
                                                menu: value.snackList[index]!);
                                          },
                                        );
                                      } else {
                                        return ListView.builder(
                                          itemCount:
                                              value.menuResponse.menu?.length ??
                                                  0,  
                                          itemBuilder: (context, index) {
                                            return MenuCardComponents(
                                                menu: value
                                                    .menuResponse.menu![index]);
                                          },
                                        );
                                      }
                                    }).toList()),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: value.searchResult.length,
                          itemBuilder: (context, index) {
                            return MenuCardComponents(
                                menu: value.searchResult[index]!);
                          },
                        ),
            ),
          );
        });
  }

  Widget shimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 18.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      height: 80.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 6,
            ),
          ],
        ),
      ),
    );
  }
}
