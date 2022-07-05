import 'package:get/get.dart';
import 'package:javacode/Constant/Core/base_url_const.dart';
import 'package:javacode/Constant/Core/endpoint_const.dart';
import 'package:javacode/Modules/Models/login_response_model.dart';

class NetworkService extends GetConnect {
  BaseUrlConst baseUrlConst = BaseUrlConst();
  @override
  void onInit() {
    
    //1.base_url
    httpClient.baseUrl = "http://base_url here";
    
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 8);
    httpClient.addResponseModifier((request, response) async {
      print(response.body);
    });

    // httpClient.addRequestModifier((request) async{
      
    //   return request;
    // });
    // httpClient.addRequestModifier((request) async {
    //   // add request here
    //   return request;
    // });
    // var headers = {'Authorization': "Bearer $token"};
    // httpClient.addAuthenticator((request) async {
    //   request.headers.addAll(headers);
    //   return request;
    // });

    super.onInit();
  }
}
