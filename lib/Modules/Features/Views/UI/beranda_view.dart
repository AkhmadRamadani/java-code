import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/beranda_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/menu_card_components.dart';
import 'package:javacode/Modules/Features/Views/Components/promo_components.dart';
import 'package:javacode/Modules/Features/Views/UI/cart_view.dart';
import 'package:javacode/Modules/Features/Views/UI/menu_detail_view.dart';
import 'package:javacode/Modules/Features/Views/UI/promo_detail_view.dart';
import 'package:javacode/Modules/Models/menu_response_model.dart';
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
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Container(
                child: FittedBox(
                  child: Stack(
                    alignment: Alignment(1.4, -1.5),
                    children: [
                      FloatingActionButton(
                        // Your actual Fab
                        onPressed: () {
                          Get.to(CartView());
                        },
                        backgroundColor: colorConst.secondaryColor,
                        child: Icon(Icons.shopping_cart),
                      ),
                      Container(
                        // This is your Badge
                        child: Center(
                          // Here you can put whatever content you want inside your Badge
                          child: Text(
                              value.orderBox.values.first.menu?.length
                                      .toString() ??
                                  "0",
                              style: TextStyle(color: Colors.white)),
                        ),
                        padding: EdgeInsets.all(8),
                        constraints:
                            BoxConstraints(minHeight: 32, minWidth: 32),
                        decoration: BoxDecoration(
                          // This controls the shadow
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: Colors.black.withAlpha(50))
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color: colorConst
                              .textColor, // This would be color of the Badge
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                              kategoriList(value),
                              selectedListMenu(value)
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: value.searchResult.length,
                          itemBuilder: (context, index) {
                            return MenuCardComponents(
                                onPressed: () {
                                  Get.to(DetailMenuView(
                                      menu: value.searchResult[index]!));
                                },
                                menu: value.searchResult[index]!);
                          },
                        ),
            ),
          );
        });
  }

  Widget selectedListMenu(BerandaController value) {
    return GetBuilder<BerandaController>(
        init: value,
        builder: (value) {
          if (value.selectedMenuIndex == 1) {
            return listDataMenu(value.makananList!, value);
          } else if (value.selectedMenuIndex == 2) {
            return listDataMenu(value.minumanList!, value);
          } else if (value.selectedMenuIndex == 3) {
            return listDataMenu(value.snackList!, value);
          } else {
            return listDataMenu(value.menuResponse.menu!, value);
          }
        });
  }

  Widget listDataMenu(List<Menu> listMenu, BerandaController value) {
    return GetBuilder<BerandaController>(
        init: value,
        builder: (value) {
          return ListView.builder(
            itemCount: listMenu.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return MenuCardComponents(
                  onPressed: () {
                    Get.to(DetailMenuView(
                      menu: listMenu[index],
                    ));
                  },
                  menu: listMenu[index]);
            },
          );
        });
  }

  Widget kategoriList(BerandaController value) {
    return GetBuilder<BerandaController>(
        init: value,
        builder: (value) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    value.changeSelectedMenu(0);
                  },
                  child: kategoriChip(value.selectedMenuIndex == 0,
                      Icons.list_rounded, "Semua Menu"),
                ),
                GestureDetector(
                  onTap: () {
                    value.changeSelectedMenu(1);
                  },
                  child: kategoriChip(value.selectedMenuIndex == 1,
                      Icons.flatware_outlined, "Makanan"),
                ),
                GestureDetector(
                  onTap: () {
                    value.changeSelectedMenu(2);
                  },
                  child: kategoriChip(value.selectedMenuIndex == 2,
                      Icons.local_drink_outlined, "Minuman"),
                ),
                GestureDetector(
                  onTap: () {
                    value.changeSelectedMenu(3);
                  },
                  child: kategoriChip(value.selectedMenuIndex == 3,
                      Icons.fastfood_outlined, "Snack"),
                ),
              ],
            ),
          );
        });
  }

  Widget kategoriChip(bool selected, IconData icon, String text) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selected ? colorConst.textColor : colorConst.secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 4,
          ),
          Center(
              child: Text(
            text,
            style: TextStyle(color: Colors.white),
          )),
        ],
      ),
    );
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
