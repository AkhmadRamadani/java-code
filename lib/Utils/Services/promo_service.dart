import 'package:javacode/Modules/Models/promo_detail_response_model.dart';
import 'package:javacode/Modules/Models/promo_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class PromoService extends NetworkService {
  Future<PromoResponse?> getPromoList() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        super.baseUrlConst.baseUrl + super.endPointConst.getPromoList,
        headers: headers);
    if (response.body['status_code'] == 200) {
      PromoResponse promoResponse = PromoResponse.fromJson(response.body);
      return promoResponse;
    } else {
      return null;
    }
  }

  Future<PromoDetailResponse?> getPromoDetail(String link) async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        link,
        headers: headers);
    print(response.body);
    if (response.body['status_code'] == 200) {
      PromoDetailResponse promoResponse =
          PromoDetailResponse.fromJson(response.body);
      return promoResponse;
    } else {
      return null;
    }
  }
}
