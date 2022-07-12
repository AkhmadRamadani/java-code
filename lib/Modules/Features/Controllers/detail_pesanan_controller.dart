import 'package:get/get.dart';
import 'package:javacode/Modules/Models/order_detail_response_model.dart';
import 'package:javacode/Utils/Services/order_service.dart';

class DetailPesananController extends GetxController {
  OrderService orderService = OrderService();
  DetailPesananController({required this.id_order});
  int id_order;
  GetOrderDetailResponse? orderDetailResponse;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetailPesanan();
  }

  getDetailPesanan() async {
    isLoading = true.obs;
    update();
    GetOrderDetailResponse? detail =
        await orderService.getDetailOrder(id_order.toString());

    if (detail != null) {
      orderDetailResponse = detail;
    }
    isLoading = false.obs;
    update();
  }
}
