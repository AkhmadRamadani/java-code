import 'package:javacode/Modules/Models/menu_detail_response_model.dart';
import 'package:javacode/Modules/Models/menu_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class MenuService extends NetworkService {
  Future<GetMenuResponse?> getMenuList() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        super.baseUrlConst.baseUrl + super.endPointConst.getMenuList,
        headers: headers);
    // print(response.body);
    if (response.body['status_code'] == 200) {
      GetMenuResponse promoResponse = GetMenuResponse.fromJson(response.body);
      return promoResponse;
    } else {
      return null;
    }
  }
  Future<MenuDetailResponse?> getMenuDetail(int id) async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        super.baseUrlConst.baseUrl + super.endPointConst.getMenuDetail + id.toString(),
        headers: headers);
    // print(response.body);
    if (response.body['status_code'] == 200) {
      MenuDetailResponse detailResponse = MenuDetailResponse.fromJson(response.body);
      return detailResponse;
    } else {
      return null;
    }
  }
}
