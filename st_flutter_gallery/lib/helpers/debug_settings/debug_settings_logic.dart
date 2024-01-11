import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/config/env_config.dart';
import 'package:st/services/sp_service/sp_service.dart';

class DebugSettingsLogic extends GetxController {
  ValueNotifier<bool> useHttps = ValueNotifier(false);
  ValueNotifier<bool> lamentGrey = ValueNotifier(false);

  @override
  void onInit() {
    useHttps.value = EnvConfig.useHttps;
    lamentGrey.value = EnvConfig.isLamentGrey;
    super.onInit();
  }

  @override
  void onClose() {
    useHttps.dispose();
    super.onClose();
  }

  Future<void> setUseHttps(bool isUseHttps) async {
    useHttps.value = isUseHttps;
    await SpService.setBool(
      SpKeys.isUseHttps,
      isUseHttps,
    );
    EnvConfig.useHttps = isUseHttps;

    showToast("${isUseHttps ? "启用".tr : "关闭".tr}HTTPS，重启生效");
  }

  Future<void> setLamentGrey(bool isLamentGrey) async {
    lamentGrey.value = isLamentGrey;
    await SpService.setBool(
      SpKeys.isLamentGrey,
      isLamentGrey,
    );
    EnvConfig.isLamentGrey = isLamentGrey;

    showToast("${isLamentGrey ? "启用".tr : "关闭".tr}哀悼灰，重启生效");
  }

  Future<void> clearSharedPreferences() async {
    await SharedPreferences.getInstance().then((value) => value.clear());

    showToast("SharedPreferences清理完毕，重启生效");
  }
}
