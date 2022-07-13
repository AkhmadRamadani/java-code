import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:javacode/Constant/Core/assets_const.dart';
import 'package:javacode/Constant/Core/colors_const.dart';
import 'package:javacode/Modules/Features/Controllers/profile_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/app_bar_components.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';
import 'package:intl/intl.dart';
import 'package:javacode/Modules/Features/Views/Components/loading_components.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final ColorConst colorConst = ColorConst();
  final AssetsConst assetsConst = AssetsConst();
  DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (value) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBarComponents(
                  title: 'profil'.tr,
                  showBackPress: false,
                ),
                body: Stack(
                  children: [
                    SafeArea(
                      child: Column(
                        children: [
                          // _buildAppBar(context),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      assetsConst.imagesPath +
                                          assetsConst.pattern2Image,
                                      scale: 1.2,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildProfilePicture(context, value),
                                        // value.userDetail?.userDetailData?.ktp !=
                                        //         null
                                        //     ? Container()
                                        //     :
                                        InkWell(
                                          onTap: () {
                                            value.uploadImageKTP(
                                                ImageSource.camera);
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(assetsConst
                                                          .imagesPath +
                                                      assetsConst
                                                          .identityIconBlue),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 8),
                                                  child: Text(
                                                    "verif_id".tr,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: colorConst
                                                          .secondaryColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 16),
                                          child: Text(
                                            "acc_info".tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: colorConst.secondaryColor,
                                            ),
                                          ),
                                        ),
                                        _buildAccountInfo(context, value),
                                        _buildRatingInfo(),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 16),
                                          child: Text(
                                            "other_info".tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: colorConst.secondaryColor,
                                            ),
                                          ),
                                        ),
                                        _builtOtherInfo(context, value),
                                        _buildLogoutButton(context, value)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    value.croppedFileKTP != null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white.withOpacity(0.9),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 320,
                                    height: 180,
                                    child: Image.file(
                                      File(
                                        value.croppedFileKTP!.path,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          value.croppedFileKTP = null;
                                          value.pickedFileKTP = null;
                                          value.update();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: ButtonComponents(
                                            buttonColor: colorConst.dangerColor,
                                            buttonTitle: "cancel".tr,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          value.updateKTP();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: ButtonComponents(
                                            buttonTitle: "upload".tr,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              value.isLoading.isTrue ? LoadingComponent() : Container(),
            ],
          );
        });
  }

  Widget _buildProfilePicture(
      BuildContext context, ProfileController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: colorConst.secondaryColor,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(80),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: controller.userDetail?.userDetailData?.foto !=
                                null
                            ? controller.croppedFile != null
                                ? Image.file(
                                    File(
                                      controller.croppedFile!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    controller.userDetail?.userDetailData?.foto,
                                    fit: BoxFit.cover,
                                  )
                            : controller.croppedFile != null
                                ? Image.file(
                                    File(
                                      controller.croppedFile!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    assetsConst.imagesPath +
                                        assetsConst.circleProfileIcon,
                                  ),
                      ),
                      InkWell(
                        onTap: () {
                          // changeProfilePicture();
                          showBottomSheet(
                            elevation: 24,
                            context: context,
                            builder: (context) {
                              return _showBottomSheetImagePicker(context);
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    color: colorConst.secondaryColor,
                                    child: Text(
                                      'edit'.tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            controller.croppedFile != null
                ? Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          controller.updateProfile();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                            12,
                          ),
                          decoration: BoxDecoration(
                              color: colorConst.secondaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'save'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  Container _builtOtherInfo(
      BuildContext context, ProfileController controller) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: const Color.fromRGBO(246, 246, 246, 1),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: Colors.grey.withAlpha(70),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "device_info".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      Platform.isAndroid
                          ? controller.androidDeviceInfo?.model ?? ""
                          : Platform.isIOS
                              ? controller.iosDeviceInfo?.model ?? ""
                              : "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "version".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      controller.packageInfo.version,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }

  Row _buildLogoutButton(BuildContext context, ProfileController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
            onTap: () {
              controller.logout();
            },
            child: Container(
              width: 200,
              child: ButtonComponents(
                buttonTitle: 'logout'.tr,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildRatingInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: const Color.fromRGBO(246, 246, 246, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.grey.withAlpha(70),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 20,
                height: 20,
                child: Image.asset(
                  assetsConst.imagesPath + assetsConst.bubbleRatingIcon,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Text(
                  "rating".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 135,
            child: ButtonComponents(
              buttonTitle: "rate_now".tr,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAccountInfo(BuildContext context, ProfileController value) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: const Color.fromRGBO(246, 246, 246, 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.grey.withAlpha(70),
          )
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showBottomSheet(
                elevation: 24,
                context: context,
                builder: (context) {
                  return _showBottomSheetUpdateProfile(
                    context,
                    'nama',
                    "name".tr,
                    value.userDetail?.userDetailData?.nama ?? "",
                    value,
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "name".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      value.userDetail?.userDetailData?.nama ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          InkWell(
            onTap: () {
              showBottomSheet(
                elevation: 24,
                context: context,
                builder: (context) {
                  return _showBottomSheetUpdateProfile(
                      context,
                      'tgl_lahir',
                      "date_of_birth".tr,
                      value.userDetail?.userDetailData?.tglLahir ?? "",
                      value,
                      datePicker: true);
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "date_of_birth".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      value.userDetail?.userDetailData?.tglLahir ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          InkWell(
            onTap: () {
              showBottomSheet(
                elevation: 24,
                context: context,
                builder: (context) {
                  return _showBottomSheetUpdateProfile(
                    context,
                    'telepon',
                    "phone_number".tr,
                    value.userDetail?.userDetailData?.telepon ?? "",
                    value,
                    keyboardType: TextInputType.phone,
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "phone_number".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      value.userDetail?.userDetailData?.telepon ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          InkWell(
            onTap: () {
              controller.userData!.isGoogle == 1
                  ? Get.snackbar(
                      "cant_edit_email_title".tr, "cant_edit_email_message".tr)
                  : showBottomSheet(
                      elevation: 24,
                      context: context,
                      builder: (context) {
                        return _showBottomSheetUpdateProfile(
                            context,
                            'email',
                            'Email',
                            value.userDetail?.userDetailData?.email ?? "",
                            value,
                            keyboardType: TextInputType.emailAddress);
                      },
                    );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      value.userDetail?.userDetailData?.email ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          InkWell(
            onTap: () {
              showBottomSheet(
                elevation: 24,
                context: context,
                builder: (context) {
                  return _showBottomSheetUpdateProfile(
                      context, 'pin', 'Pin', "", value,
                      keyboardType: TextInputType.number, maxLength: 6);
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "change_pin".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '*******',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            child: InkWell(
              onTap: () {
                showBottomSheet(
                  elevation: 24,
                  context: context,
                  builder: (context) {
                    return _showBottomSheetChangeLanguage(
                      context,
                      controller,
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "change_lang".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        controller.selectedLanguage!.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Wrap _showBottomSheetUpdateProfile(BuildContext context, String key,
      String label, String initialValue, ProfileController controller,
      {TextInputType? keyboardType,
      bool datePicker = false,
      int maxLength = -1}) {
    String savedValue = initialValue;
    TextEditingController textEditingController = TextEditingController()
      ..text = savedValue
      ..selection =
          TextSelection.fromPosition(TextPosition(offset: savedValue.length));

    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  'Update $label',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: keyboardType ?? TextInputType.text,
                      readOnly: datePicker,
                      controller: textEditingController,
                      onChanged: (value) {
                        savedValue = value;
                        // controller.updateValueData(key, value);
                      },
                      onTap: () {
                        datePicker
                            ? showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970, 1),
                                lastDate: DateTime.now(),
                                builder: (context, picker) {
                                  return Theme(
                                    //TODO: change colors
                                    data: ThemeData.light().copyWith(),
                                    child: picker!,
                                  );
                                }).then((selectedDate) {
                                //TODO: handle selected date
                                if (selectedDate != null) {
                                  print('selected date' +
                                      formatter
                                          .format(selectedDate)
                                          .toString());
                                  textEditingController.text =
                                      formatter.format(selectedDate).toString();
                                  savedValue =
                                      formatter.format(selectedDate).toString();
                                  // controller.update();
                                }
                              })
                            : null;
                      },
                      maxLength: maxLength == -1 ? 100 : maxLength,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.grey.withAlpha(100),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: colorConst.secondaryColor,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          controller.updateData(key, savedValue);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.check),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Wrap _showBottomSheetChangeLanguage(
      BuildContext context, ProfileController controller) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  "change_lang".tr,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateLanguage('id');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: controller.selectedLanguage == 'id'
                                ? colorConst.secondaryColor
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 56,
                                height: 38,
                                child: Image.asset(
                                  assetsConst.imagesPath +
                                      assetsConst.indonesiaFlag,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'Indonesia',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: controller.selectedLanguage == 'id'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Icon(Icons.check,
                                    size: 24, color: Colors.white
                                    // : Colors.black,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateLanguage('en');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: controller.selectedLanguage == 'en'
                                ? colorConst.secondaryColor
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 56,
                                height: 38,
                                child: Image.asset(
                                  assetsConst.imagesPath + assetsConst.ukFlag,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'Inggris',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: controller.selectedLanguage == 'en'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Icon(Icons.check,
                                    size: 24, color: Colors.white
                                    // : Colors.black,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Wrap _showBottomSheetImagePicker(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  "choose_image".tr,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.uploadImage(ImageSource.camera);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: colorConst.secondaryColor,
                            // : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 36,
                                color: Colors.white,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'camera'.tr,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white
                                      // : Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.uploadImage(ImageSource.gallery);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: colorConst.secondaryColor,
                            // : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.image,
                                size: 36,
                                color: Colors.white,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'gallery'.tr,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white
                                      // : Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
