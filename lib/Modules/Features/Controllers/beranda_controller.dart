import 'package:get/get.dart';
import 'package:javacode/Modules/Models/promo_response_model.dart';
import 'package:javacode/Utils/Services/promo_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BerandaController extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  PromoService promoService = PromoService();
  RxBool isLoading = false.obs;
  PromoResponse promoResponse = PromoResponse();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPromoList();
  }

  void onRefresh() async {
    isLoading = true.obs;
    update();
    // monitor network fetch
    await Future.delayed(Duration(seconds: 3));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
    isLoading = false.obs;
    update();
  }

  void getPromoList() async {
    isLoading = true.obs;
    update();

    PromoResponse? promoResponse = await promoService.getPromoList();

    if (promoResponse != null) {
      this.promoResponse = promoResponse;
    }
    refreshController.refreshCompleted();

    isLoading = false.obs;
    update();
  }
}
