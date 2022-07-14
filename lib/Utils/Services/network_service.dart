import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Constant/Core/base_url_const.dart';
import 'package:javacode/Constant/Core/endpoint_const.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart' as user_hive;
import 'package:javacode/Modules/Models/login_response_model.dart';

class NetworkService extends GetConnect {
  BaseUrlConst baseUrlConst = BaseUrlConst();
  EndPointConst endPointConst = EndPointConst();
  var box = Hive.box<user_hive.User>('user');
  
  @override
  void onInit() {    

    //1.base_url
    httpClient.baseUrl = baseUrlConst.baseUrl;

    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 8);
    httpClient.addResponseModifier((request, response) async {
      // print(response.body);
    });

    Map<String, String> headers = {'token': box.values.first.token ?? ""};
    // httpClient.addRequestModifier((request) async {
    //   request.headers.addAll(headers);
    //   return request.
    // });

    // var headers = {'Authorization': "Bearer $token"};
    // httpClient.addAuthenticator((request) async {
    //   request.headers.addAll(headers);
    //   return await request;
    // });

    super.onInit();
  }

  // void get
}
