import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/models/user_info/user_info.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/cookie_jar_manager/cookie_jar_manager.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/common/engine.dart';
import 'package:st/common/global.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((d) async {
      Engine.allowRender();

      try {
        await initApp();
      } on Exception catch (e) {
        await initApp();
        logger.info(e);
      }
    });
  }

  Future<void> initApp() async {
    if (!CookieJarManager.isHaveCookie) {
      if (Get.currentRoute != Routes.LOGIN_PAGE) {
        unawaited(Get.offAllNamed(Routes.LOGIN_PAGE));
      }
    } else {
      try {
        final apiResponseModel = await Http.post(
          Apis.getUserInfo,
          needOriginalData: true,
        );
        final data = apiResponseModel?.response?.data;
        final userInfo = UserInfo.fromJson(data);
        if (userInfo.code.isNotEmpty && userInfo.name.isNotEmpty) {
          Global.loginUserInfo = userInfo;
        }

        unawaited(Get.offAllNamed(Routes.HOME));
      } on Exception catch (e) {
        logger.warning(e);
        if (Get.currentRoute != Routes.LOGIN_PAGE) {
          unawaited(
            Get.offAllNamed(Routes.LOGIN_PAGE),
          );
        }
      }
    }
  }

  @override
  void onClose() {}
}
