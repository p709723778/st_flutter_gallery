import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (logic) {
        return Container(
          alignment: Alignment.bottomCenter,
          color: Colors.white,
          padding: EdgeInsets.only(
            bottom: 48 + MediaQuery.of(context).padding.bottom,
          ),
          child: Image.asset(
            "assets/images/main/app_logo.png",
            width: 48,
            height: 62,
          ),
        );
      },
    );
  }
}
