import 'package:javacode/Modules/Models/my_voucher_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class VoucherService extends NetworkService{
  Future<GetMyVoucherResponse?> getMyVoucher() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        super.baseUrlConst.baseUrl +
            super.endPointConst.getAllVoucher,
            // super.box.values.first.idUser.toString(),
        headers: headers);
    // print(response.body);
    if (response.body['status_code'] == 200) {
      GetMyVoucherResponse myVoucherResponse =
          GetMyVoucherResponse.fromJson(response.body);
      return myVoucherResponse;
    } else {
      return null;
    }
  }
}