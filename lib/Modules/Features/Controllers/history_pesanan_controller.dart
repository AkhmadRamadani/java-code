import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';
import 'package:javacode/Modules/Features/Views/UI/pesanan_tracking_view.dart';
import 'package:javacode/Modules/Models/add_order_response.dart';
import 'package:javacode/Modules/Models/history_order_response_model.dart';
import 'package:javacode/Modules/Models/order_response_model.dart';
import 'package:javacode/Utils/Services/order_service.dart';
import 'package:intl/intl.dart';

class HistoryPesananController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;
  GetOrderResponse? order;
  GetHistoryOrderResponse? orderHistory;
  OrderService historyService = OrderService();
  RxBool isLoading = false.obs;
  List<Order> listHistoryOrderFilterred = [];
  List<Order> listHistoryOrderFilterredDone = [];
  List<Order> listHistoryOrderFilterredBatal = [];
  List<Order> listHistoryOrderDataAll = [];
  List<Order> listHistoryOrderData = [];

  var dropdownItems = [
    'all_status'.tr,
    'done'.tr,
    'canceled'.tr,
  ];

  var selectedDropdownItem = 'all_status'.tr;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = TabController(vsync: this, length: 2);
    initialFun();
  }

  DateTimeRange? selectedDateRange;
  DateTime? startDate;
  DateTime? endDate;

  String startDateString = "";
  String endDateString = "";

  DateFormat formatter = DateFormat('dd/MM/yy');
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  void showMyDatePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'done'.tr,
    );

    if (result != null) {
      // Rebuild the UI
      selectedDateRange = result;
      startDate = result.start;
      endDate = result.end;

      startDateString = formatter.format(startDate!).toString();
      endDateString = formatter.format(endDate!).toString();

      await filterDataInDateRange();
    }
    update();
  }

  initialFun() async {
    isLoading = true.obs;
    update();
    endDate = DateTime.now();
    startDate = endDate!.subtract(Duration(days: 7));

    startDateString = formatter.format(startDate!).toString();
    endDateString = formatter.format(endDate!).toString();

    await getHistoryOrder();
    await getListOrderOnTracking();

    // print("panjang " + listHistoryOrderFilterred.length.toString());
    isLoading = false.obs;
    update();
  }

  getHistoryOrder() async {
    GetHistoryOrderResponse? order = await historyService.getHistoryOrder();

    if (order != null) {
      orderHistory = order;
      listHistoryOrderFilterred = order.data!.listData!;
      listHistoryOrderData = order.data!.listData!;
      listHistoryOrderDataAll.addAll(order.data!.listData!);
      List<Order> listHistoryOrderDone =
          listHistoryOrderData.where((i) => i.status == 3).toList();

      List<Order> listHistoryOrderBatal =
          listHistoryOrderData.where((i) => i.status == 4).toList();

      listHistoryOrderFilterredBatal = listHistoryOrderBatal;
      listHistoryOrderFilterredDone = listHistoryOrderDone;

      // await filterData();
    }
  }

  getListOrderOnTracking() async {
    GetOrderResponse? order = await historyService.getOrderListByUser();

    if (order != null) {
      this.order = order;
    }
  }

  filterDataInDateRange() async {
    await filterData(selectedDropdownItem);
    List<Order> tempOrder = [];
    tempOrder.addAll(listHistoryOrderFilterred);
    listHistoryOrderFilterred.clear();

    for (var i = 0; i < tempOrder.length; i += 1) {
      var date = dateFormat.parse(tempOrder[i].tanggal!);
      if (date.compareTo(startDate!) >= 0 && date.compareTo(endDate!) <= 0) {
        listHistoryOrderFilterred.add(tempOrder[i]);
      }
    }
  }

  pesanLagiFunction(Order order) async {
    showDialog(
        context: Get.context!,
        builder: (builder) {
          return AlertDialog(
            title: Text("re_order_asking".tr),
            actions: [
              GestureDetector(
                onTap: () async {
                  AddOrderResponse? isSent =
                      await historyService.reOrderReques(order);

                  if (isSent != null) {
                    Get.snackbar(
                        "order_menu_success_title".tr,
                        "order_menu_success_message".trParams({
                          'length': '${order.menu?.length ?? 0}',
                          'totalBayar': ' ${order.totalBayar}'
                        }));
                    Get.close(1);
                    Get.to(PesananTrackingView(id: isSent.dataOrder!.idOrder!));
                  }
                },
                child: Container(
                  width: 100,
                  child: ButtonComponents(
                    buttonTitle: "ok".tr,
                  ),
                ),
              )
            ],
          );
        });
  }

  filterData(String data) async {
    // if (selectedDateRange == null) {
    listHistoryOrderFilterred.clear();
    // }
    // print(data);
    selectedDropdownItem = data;

    switch (data) {
      case 'Selesai':
        listHistoryOrderFilterred.addAll(listHistoryOrderFilterredDone);
        break;
      case 'Done':
        listHistoryOrderFilterred.addAll(listHistoryOrderFilterredDone);
        break;
      case 'Dibatalkan':
        listHistoryOrderFilterred.addAll(listHistoryOrderFilterredBatal);
        break;
      case 'Canceled':
        listHistoryOrderFilterred.addAll(listHistoryOrderFilterredBatal);
        break;
      default:
        listHistoryOrderFilterred.addAll(listHistoryOrderDataAll);
        break;
    }

    // listHistoryOrderData.forEach((Order data) {
    //   // print("here");
    //   if (selectedDropdownItem == 'Selesai') {
    //     // print("true selesai");
    //     if (data.status == 3) {
    //       listHistoryOrderFilterred.add(data);
    //     }
    //   } else if (selectedDropdownItem == 'Dibatalkan') {
    //     // print("true batal");

    //     if (data.status == 4) {
    //       listHistoryOrderFilterred.add(data);
    //     }
    //   } else {
    //     // print("true semua");

    //     listHistoryOrderFilterred.add(data);
    //   }
    //   // update();
    // });
    // print("panjang " + listHistoryOrderFilterred.length.toString());

    update();
  }

  updateDropdownItem(int index) {
    selectedDropdownItem = dropdownItems[index];
    update();
  }
}
