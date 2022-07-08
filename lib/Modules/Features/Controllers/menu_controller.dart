import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:javacode/Modules/Models/Hive/menu_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/topping_hive_model.dart';
import 'package:javacode/Modules/Models/menu_detail_response_model.dart';
import 'package:javacode/Modules/Models/menu_response_model.dart';
import 'package:javacode/Utils/Services/menu_service.dart';

class MenuController extends GetxController {
  MenuService menuService = MenuService();
  MenuDetailResponse? menuDetailResponse;
  RxBool isLoading = false.obs;

  TextEditingController catatanController = TextEditingController();
  OrderHive? orderHive;
  MenuHive menuHive = MenuHive();

  Menu menu = Menu();

  var orderBox = Hive.box<OrderHive>('order');

  Future<void> share() async {
    Menu? menu = menuDetailResponse!.data!.menu;
    await FlutterShare.share(
        title: menu?.nama ?? "",
        text:
            "Dapatkan ${menu?.kategori ?? ""} ${menu?.nama ?? ""} dengan harga Rp. ${menu?.harga ?? ""} hanya di Aplikasi JavaCode",
        linkUrl:
            "https://trainee.landa.id/javacode/menu/detail/${menu?.idMenu ?? ""}",
        chooserTitle: menu?.nama);
  }

  void onChangedCatatan(String note) {
    menuHive.catatan = note;
    update();
  }

  void getMenu(int id) async {
    isLoading = true.obs;
    update();

    menuDetailResponse = await menuService.getMenuDetail(id);
    // update();
    menu = menuDetailResponse!.data!.menu!;
    menuHive.nama = menu.nama ?? "";
    menuHive.gambar = menu.foto ?? "";
    menuHive.harga = menu.harga ?? 0;
    menuHive.id_menu = menu.idMenu ?? 0;
    menuHive.jumlah = 1;
    menuHive.level = 0;
    menuHive.kategori = menu.kategori ?? "";
    isLoading = false.obs;
    update();
  }

  addAmount() {
    menuHive.jumlah = menuHive.jumlah! + 1;
    menuHive.harga = menuHive.harga! + menu.harga!;
    update();
  }

  subtractAmount() {
    if (menuHive.jumlah! > 1) {
      menuHive.jumlah = menuHive.jumlah! - 1;

      menuHive.harga = menuHive.harga! - menu.harga!;
      update();
    }
  }

  String getToppingName(List<String?> data) {
    String result = "";

    return data.join(", ");
  }

  void chooseLevel(Level level, int index) {
    if (menuHive.level != level.idDetail) {
      if (menuHive.level != 0) {
        Iterable<Level> oldLevel = menuDetailResponse!.data!.level!
            .where((Level element) => element.idDetail == menuHive.level)
            .toList();
        menuHive.harga = menuHive.harga! - oldLevel.first.harga!;
      }

      menuHive.keteranganLevel = level.keterangan!;
      menuHive.level = level.idDetail;
      menuHive.harga = menuHive.harga! + level.harga!;
      update();
    }
  }

  void addTopping(Level topping, int index) {
    int isAny = menuHive.toppingDetail!
        .indexWhere((element) => element.idDetail == topping.idDetail);

    if (isAny >= 0) {
      menuHive.toppingDetail!
          .removeWhere((element) => element.idDetail == topping.idDetail);

      menuHive.harga = menuHive.harga! - topping.harga!;
      menuDetailResponse!.data!.topping![index].isSelected = false;
    } else {
      Topping newTopping = Topping();
      newTopping.harga = topping.harga;
      newTopping.idDetail = topping.idDetail;
      newTopping.idMenu = topping.idMenu;
      newTopping.isSelected = true;
      newTopping.keterangan = topping.keterangan;
      newTopping.type = topping.type;

      menuHive.toppingDetail!.add(newTopping);

      menuHive.harga = menuHive.harga! + topping.harga!;
      menuDetailResponse!.data!.topping![index].isSelected = true;
    }
    update();
  }

  void addMenu() {
    // print(orderBox.values.length.toString());
    OrderHive tempOrderHive = orderBox.values.first;
    tempOrderHive.menu!.add(menuHive);
    tempOrderHive.totalBayar = tempOrderHive.totalBayar! + menuHive.harga!;
    orderBox.put(orderBox.keys.first, tempOrderHive);
    Get.snackbar(
        "Sukses Menambahkan",
        menuHive.jumlah.toString() +
            " " +
            menuHive.nama +
            " Rp. " +
            menuHive.harga.toString());
    print(orderBox.values.first.menu!.length.toString());
    menuHive = MenuHive();
    menuHive.nama = menu.nama ?? "";
    menuHive.gambar = menu.foto ?? "";
    menuHive.harga = menu.harga ?? 0;
    menuHive.id_menu = menu.idMenu ?? 0;
    menuHive.jumlah = 1;
    menuHive.level = 0;
    menuHive.kategori = menu.kategori ?? "";
    update();
  }
}
