import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:st/app/models/user_info/user_info.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/cookie_jar_manager/cookie_jar_manager.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/common/global.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class UserProfileController extends GetxController {
  final count = 0.obs;

  UserInfo currentUserInfo = Global.loginUserInfo;

  @override
  void onInit() {
    requestUserInfo();
    super.onInit();
  }

  @override
  void onClose() {}

  Future<void> requestUserInfo() async {
    final apiResponseModel = await Http.post(
      Apis.getUserInfo,
      needOriginalData: true,
    );
    final data = apiResponseModel?.response?.data;
    final userInfo = UserInfo.fromJson(data);
    if (userInfo.code.isNotEmpty && userInfo.name.isNotEmpty) {
      Global.loginUserInfo = userInfo;
      currentUserInfo = userInfo;
    }
    update();
  }

  Future<void> logout() async {
    try {
      await EasyLoading.show(status: '退出登录中...');
      final apiResponseModel = await Http.post(
        Apis.logout,
        needOriginalData: true,
      );
      CookieJarManager.deleteCookie();
      unawaited(Get.offAllNamed(Routes.LOGIN_PAGE));
      logger.info(apiResponseModel);
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
  }

  void testCode() {
    final context = Get.context!;
    showDatePicker(
      context: context, //上下文对象
      initialDate: DateTime.now(), //初始化显示的日期
      firstDate: DateTime(2019),
      lastDate: DateTime(2024),
    );
  }
}
