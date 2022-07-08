import 'package:get/get.dart';
import 'package:javacode/Modules/Models/my_voucher_response_model.dart';
import 'package:javacode/Utils/Services/voucher_service.dart';

class VoucherController extends GetxController {
  VoucherService voucherService = VoucherService();
  GetMyVoucherResponse? myVoucherResponse;
  Voucher? selectedVoucher;
  Voucher? detailVoucher;
  RxBool isLoading = false.obs;

  getMyVoucherList() async {
    isLoading = true.obs;
    update();

    GetMyVoucherResponse? myVoucherResponse =
        await voucherService.getMyVoucher();

    if (myVoucherResponse != null) {
      this.myVoucherResponse = myVoucherResponse;
    }
    isLoading = false.obs;
    update();
  }

  setSelectedVoucher(int index) {
    if (myVoucherResponse!.voucher![index].isSelected == true) {
      myVoucherResponse!.voucher![index].isSelected = false;
      selectedVoucher = null;
    } else {
      myVoucherResponse!.voucher!.forEach((element) {
        element.isSelected = false;
      });
      myVoucherResponse!.voucher![index].isSelected =
          !(myVoucherResponse!.voucher![index].isSelected ?? false);
      selectedVoucher = myVoucherResponse!.voucher![index];
    }

    update();
  }

  getDetailVoucher(int index) {
    detailVoucher = myVoucherResponse!.voucher![index];
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyVoucherList();
  }
}
