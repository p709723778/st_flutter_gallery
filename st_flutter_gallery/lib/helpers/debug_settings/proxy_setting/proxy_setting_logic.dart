import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/services/sp_service/sp_service.dart';

class ProxySettingLogic extends GetxController {
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  ValueNotifier<bool> useProxy = ValueNotifier(false);

  @override
  void onInit() {
    final isUseProxy = SpService.getBool(SpKeys.isUseProxy) ?? false;

    if (isUseProxy) {
      textEditingController.text = SpService.getString(SpKeys.networkProxy)!;
    }
    useProxy.value = isUseProxy;
    textEditingController.addListener(refreshText);
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController
      ..removeListener(refreshText)
      ..dispose();
    focusNode.dispose();
    super.onClose();
  }

  void refreshText() {
    update();
  }

  Future<void> setUseProxy(bool isUseProxy) async {
    useProxy.value = isUseProxy;
    if (isUseProxy == false) {
      await SpService.setBool(SpKeys.isUseProxy, useProxy.value);
      showToast("${isUseProxy ? "启用".tr : "关闭".tr}代理，重启生效");
    }
    update();
  }

  Future<void> saveProxyAddress() async {
    final text = textEditingController.text.trim();

    if (!RegExp(r"^(\d{1,3}\.){3}\d{1,3}:\d{2,5}$").hasMatch(text)) {
      showToast("IP 地址格式错误".tr);
    } else {
      await SpService.setBool(SpKeys.isUseProxy, useProxy.value);
      await SpService.setString(SpKeys.networkProxy, text);
      showToast("重启生效 代理：$text");
      focusNode.unfocus();
    }
  }
}
