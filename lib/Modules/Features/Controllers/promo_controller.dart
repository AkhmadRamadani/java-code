import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Models/promo_response_model.dart';

class PromoController extends GetxController {
  Promo? promo;

  PromoController({this.promo});
  
  Future<void> share() async {
    await FlutterShare.share(
        title: promo!.nama ?? "",
        text: "Dapatkan Promo ${promo!.type} ${promo!.nama} senilai Rp. ${promo!.nominal} hanya di Aplikasi JavaCode",
        linkUrl: "https://trainee.landa.id/javacode/promo/detail/${promo!.idPromo}",
        chooserTitle: promo!.nama);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(promo == null){

    }
  }

}
