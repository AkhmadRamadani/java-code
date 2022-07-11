import 'package:javacode/Modules/Models/diskon_response_model.dart';
import 'package:javacode/Utils/Services/network_service.dart';

class DiskonService extends NetworkService {
  Future<GetDiskonResponse?> getMyDiskon() async {
    Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
    final response = await get(
        super.baseUrlConst.baseUrl +
            super.endPointConst.getMyDiskon +
            super.box.values.first.idUser.toString(),
        headers: headers);
    print(response.body);
    if (response.body['status_code'] == 200) {
      GetDiskonResponse diskonResponse =
          GetDiskonResponse.fromJson(response.body);
      return diskonResponse;
    } else {
      return null;
    }
  }
}
