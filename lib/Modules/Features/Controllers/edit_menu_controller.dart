import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Features/Controllers/menu_controller.dart';
import 'package:javacode/Modules/Models/Hive/menu_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/menu_detail_response_model.dart';
import 'package:javacode/Modules/Models/menu_response_model.dart';
import 'package:javacode/Utils/Services/menu_service.dart';

class EditMenuController extends MenuController {
  // var orderBox = Hive.box<OrderHive>('order');
  // MenuHive menuHive = MenuHive();
  // RxBool isLoading = false.obs;
  // MenuDetailResponse? menuDetailResponse;
  // Menu? menu;
  // MenuService menuService = MenuService();
  int index = 0;
  EditMenuController({required this.index});
  int hargaAwal = 0;
  MenuHive tempMenuHive = MenuHive();
  bool isUpdated = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMenuHive(index);
  }

  @override
  Future<void> getMenu(int id) async {
    menuDetailResponse = await menuService.getMenuDetail(id);
    // menu = menuDetailResponse!.data!.menu!;
    if (menuDetailResponse != null) {
      menu = menuDetailResponse!.data!.menu!;

      if (menuDetailResponse!.data!.topping != null) {
        int index = 0;
        menuDetailResponse!.data!.topping!.forEach((element) {
          menuHive.toppingDetail!.forEach((checker) {
            if (element.idDetail == checker.idDetail) {
              menuDetailResponse!.data!.topping![index].isSelected = true;
            }
          });
          index += 1;
        });
      }
    }
  }

  getMenuHive(int index) async {
    isLoading = true.obs;
    update();

    MenuHive dataTemp = MenuHive()
      ..nama = orderBox.values.first.menu![index].nama
      ..catatan = orderBox.values.first.menu![index].catatan
      ..gambar = orderBox.values.first.menu![index].gambar
      ..harga = orderBox.values.first.menu![index].harga
      ..hargaAsli = orderBox.values.first.menu![index].hargaAsli
      ..hargaLevel = orderBox.values.first.menu![index].hargaLevel
      ..id_menu = orderBox.values.first.menu![index].id_menu
      ..jumlah = orderBox.values.first.menu![index].jumlah
      ..kategori = orderBox.values.first.menu![index].kategori
      ..keteranganLevel = orderBox.values.first.menu![index].keteranganLevel
      ..level = orderBox.values.first.menu![index].level
      ..topping = orderBox.values.first.menu![index].topping
      ..toppingDetail = orderBox.values.first.menu![index].toppingDetail
      ..totalHargaTopping = orderBox.values.first.menu![index].totalHargaTopping;

    tempMenuHive = dataTemp;
    menuHive = orderBox.values.first.menu![index];
    hargaAwal = menuHive.harga!;

    await getMenu(menuHive.id_menu!);
    isLoading = false.obs;
    update();
  }

  simpanEditMenu() {
    OrderHive tempOrderHive = orderBox.values.first;
    tempOrderHive.menu![index] = menuHive;
    tempOrderHive.totalBayar =
        (tempOrderHive.totalBayar! - hargaAwal) + menuHive.harga!;
    orderBox.put(orderBox.keys.first, tempOrderHive);
    Get.snackbar(
        "Sukses Mengedit Barang",
        menuHive.jumlah.toString() +
            " " +
            menuHive.nama +
            " Rp. " +
            menuHive.harga.toString());
    isUpdated = true;
  }
}
