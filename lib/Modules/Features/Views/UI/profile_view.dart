import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javacode/Modules/Features/Controllers/profile_controller.dart';
import 'package:javacode/Modules/Features/Views/Components/button_components.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (value) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: (){
                  value.logout();
                },
                child: ButtonComponents(
                  buttonTitle: "Logout",
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
