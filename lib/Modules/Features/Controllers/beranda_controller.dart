import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BerandaController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxBool isLoading = false.obs;
  void onRefresh() async {
    isLoading = true.obs;
    // monitor network fetch
    await Future.delayed(Duration(seconds: 3));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }


}
