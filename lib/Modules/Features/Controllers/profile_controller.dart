import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:javacode/Modules/Features/Controllers/find_location_controller.dart';
import 'package:javacode/Modules/Features/Views/UI/login_view.dart';
import 'package:javacode/Modules/Models/Hive/order_hive_model.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';
import 'package:javacode/Modules/Models/user_detail_data_response_model.dart';
import 'package:javacode/Utils/Services/authentication_service.dart';
import 'package:javacode/Utils/Services/user_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends GetxController {
  AuthenticationService authService = AuthenticationService();
  var orderBox = Hive.box<OrderHive>('order');
  var box = Hive.box<User>('user');
  User? userData;
  GetUserDetail? userDetail;
  UserService userService = UserService();
  RxBool isLoading = false.obs;
  UserDetailData? userDetailDataTemp;
  XFile? pickedFile;
  CroppedFile? croppedFile;

  XFile? pickedFileKTP;
  CroppedFile? croppedFileKTP;

  var languageBox = Hive.box("selected_language");
  String? selectedLanguage;

  PackageInfo packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosDeviceInfo;

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      } else if (Platform.isIOS) {
        iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      }
    } catch (e) {}
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    packageInfo = info;
    update();
  }

  setUserData() async {
    isLoading = true.obs;
    update();

    GetUserDetail? getUserDetail = await userService.getUserDetail();
    userData = box.values.first;

    if (getUserDetail != null) {
      userDetail = getUserDetail;
      userDetailDataTemp = getUserDetail.userDetailData!;
    }

    isLoading = false.obs;
    update();
  }

  logout() async {
    await authService.logout();
    await orderBox.clear();
    // OrderHive orderHive = OrderHive();
    // orderHive.idUser = box.values.first.idUser;

    // await orderBox.add(orderHive);

    await box.clear();
    // Get.delete<FindLocationController>();
    Get.offAll(LoginView());
    // Get.offUntil(GetPageRoute(page: () => LoginView()), );
    // Get.to(LoginView());
  }

  Future<void> cropImage() async {
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
      );
      if (croppedFile != null) {
        this.croppedFile = croppedFile;
        update();
      }
    }
  }

  Future<void> uploadImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 60,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    if (pickedFile != null) {
      this.pickedFile = pickedFile;
      await cropImage();
    }
  }

  Future<void> cropImageKTP() async {
    if (pickedFileKTP != null) {
      final croppedFileKTP = await ImageCropper().cropImage(
        sourcePath: pickedFileKTP!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.ratio16x9
        // ],
      );
      if (croppedFileKTP != null) {
        this.croppedFileKTP = croppedFileKTP;
        update();
      }
    }
  }

  Future<File> compressImage(File file) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      file.absolute.path,
      quality: 50,
      rotate: 180,
    );

    // print(file.lengthSync());
    // print(result.lengthSync());

    return result!;
  }

  Future<void> uploadImageKTP(ImageSource imageSource) async {
    final pickedFileKTP = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 60,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    if (pickedFileKTP != null) {
      this.pickedFileKTP = pickedFileKTP;
      await cropImageKTP();
    }
  }

  updateValueData(String key, String newValue) {
    // userDetailDataTemp = userDetail!.userDetailData!;
    // Map<String, dynamic> dataTemp = userDetailDataTemp!.toJson();
    // dataTemp[key] = newValue;

    // userDetailDataTemp = UserDetailData.fromJson(dataTemp);
    // update();
  }

  updateData(String key, String newValue) async {
    isLoading = true.obs;
    update();

    GetUserDetail? getUserDetail =
        await userService.updateUserDetailByKey(key, newValue);

    if (getUserDetail != null) {
      userDetail = getUserDetail;
      userDetailDataTemp = getUserDetail.userDetailData!;
      updateUserBox(userDetailDataTemp!);
    }
    isLoading = false.obs;
    update();
  }

  updateProfile() async {
    isLoading = true.obs;
    update();

    File file = File(croppedFile!.path);

    final bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);

    GetUserDetail? getUserDetail =
        await userService.updateProfile("image", base64Image);

    if (getUserDetail != null) {
      userDetail = getUserDetail;
      userDetailDataTemp = getUserDetail.userDetailData!;
      updateUserBox(userDetailDataTemp!);

      pickedFile = null;
      croppedFile = null;
    }

    isLoading = false.obs;
    update();
  }

  updateKTP() async {
    isLoading = true.obs;
    update();

    File file = File(croppedFileKTP!.path);
    final bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);

    GetUserDetail? getUserDetail =
        await userService.updateKTP("image", base64Image);

    if (getUserDetail != null) {
      userDetail = getUserDetail;
      userDetailDataTemp = getUserDetail.userDetailData!;
      updateUserBox(userDetailDataTemp!);
      pickedFileKTP = null;
      croppedFileKTP = null;
    }

    isLoading = false.obs;
    update();
  }

  updateUserBox(UserDetailData newUserData) async {
    User user = box.values.first;

    user.nama = newUserData.nama;
    user.nama = newUserData.nama;
    user.foto = newUserData.foto;
    user.pin = newUserData.pin;

    box.put(box.keys.first, user);
  }

  setSelectedLanguage() {
    selectedLanguage = languageBox.get("country_id");
  }

  updateLanguage(String countryId) {
    languageBox.put("country_id", countryId);
    selectedLanguage = countryId;
    Get.updateLocale(Locale(countryId));
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setUserData();
    initPackageInfo();
    initPlatformState();
    setSelectedLanguage();
  }
}
