import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:javacode/Modules/Features/Views/UI/main_view.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';

class FindLocationController extends GetxController {
  late User userData;
  Position? position = null;
  Placemark? location = null;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocation();
  }

  getLocation() async {
    isLoading = true.obs;
    update();
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Get.snackbar("location_error_title".tr, "location_error_message".tr);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Get.snackbar("location_permission_error_title".tr,
          "location_permission_error_message".tr);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Get.snackbar("location_permission_error_title".tr,
          "location_permission_error_message".tr);
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> allPlacemark =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    location = allPlacemark.first;
    isLoading = false.obs;
    update();
    Timer(Duration(seconds: 3), () {
      // Get.delete(FindLocationController());
      Get.delete<FindLocationController>();

      Get.off(MainView());
    });
  }

  @override
  void dispose() {
    Get.delete<FindLocationController>();
    super.dispose();
  }
}
