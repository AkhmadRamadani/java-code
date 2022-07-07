import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Models/menu_response_model.dart';
import 'package:javacode/Modules/Models/promo_response_model.dart';
import 'package:javacode/Utils/Services/menu_service.dart';
import 'package:javacode/Utils/Services/network_service.dart';
import 'package:javacode/Utils/Services/promo_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BerandaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PromoService promoService = PromoService();
  MenuService menuService = MenuService();
  RxBool isLoading = false.obs;
  PromoResponse promoResponse = PromoResponse();
  GetMenuResponse menuResponse = GetMenuResponse();
  List<Menu?> makananList = [];
  List<Menu?> minumanList = [];
  List<Menu?> snackList = [];
  List<Menu?> searchResult = [];

  late TabController controller;
  List<String> tabs = ["semua", "makanan", "minuman", "snack"];

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = TabController(vsync: this, length: 4);
    controller.addListener(() {
      controller.index = controller.index;
      update();
    });
    onRefresh();
  }

  handleTabSelection(int index) {
    controller.index = index;
    update();
  }

  Future<void> onRefresh() async {
    isLoading = true.obs;
    update();

    await getPromoList();
    await getMenuList();

    refreshController.refreshCompleted();
    isLoading = false.obs;
    update();
  }

  Future<void> getPromoList() async {
    PromoResponse? promoResponse = await promoService.getPromoList();

    if (promoResponse != null) {
      this.promoResponse = promoResponse;
    }
  }

  Future<void> getMenuList() async {
    GetMenuResponse? menuResponse = await menuService.getMenuList();

    if (menuResponse != null) {
      this.menuResponse = menuResponse;
      makananList = menuResponse.menu!
          .where((Menu data) => data.kategori!.contains("makanan"))
          .toList();
      minumanList = menuResponse.menu!
          .where((Menu data) => data.kategori!.contains("minuman"))
          .toList();
      snackList = menuResponse.menu!
          .where((Menu data) => data.kategori!.contains("snack"))
          .toList();
    }
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (searchController.text.isEmpty) {
      update();
    }

    menuResponse.menu!.forEach((Menu data) {
      if (data.nama!.toLowerCase().contains(text) || data.deskripsi!.toLowerCase().contains(text))
        searchResult.add(data);
        // update();
    });

    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.dispose();
  }
}
