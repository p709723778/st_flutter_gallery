import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/app/models/api_response/api_response_model.dart';
import 'package:st/app/models/api_response/switch_on_model.dart';
import 'package:st/app/modules/app_tab_bar.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/services/sp_service/sp_service.dart';

class UserLoginLogic extends GetxController {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passWordController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  final _debounce = Debouncer(delay: const Duration(milliseconds: 300));

  bool _obscureText = true;

  static const int LOGIN_OBSCURE_TEXT_ID = 1;

  @override
  Future<void> onInit() async {
    // userNameController.text = 'testAdmin';
    // passWordController.text = 'Seggps2023';

    final userName = SpService.getString(SpKeys.userName) ?? '';
    final passWord = SpService.getString(SpKeys.passWord) ?? '';
    userNameController.text = userName;

    if (!_isExpired && passWord.isNotEmpty) {
      try {
        await EasyLoading.show(status: '正在登录...');
        final res = await _loginRequest(userName: userName, passWord: passWord);

        await EasyLoading.dismiss();

        if (res != null && res.isSuccess) {
          /// 登录成功, 跳转主页
          unawaited(_gotoHomePage());
        } else {
          showToast(res?.errorMessage ?? '自动登录失败');

          unawaited(_clearUserInfo());
        }
      } catch (e) {
        logger.info('自动登录失败: $e');
      }
    } else {
      unawaited(_clearUserInfo());
    }

    super.onInit();
  }

  // 清除登录密码和账号
  Future<void> _clearUserInfo() async {
    await SpService.setString(SpKeys.passWord, '');
  }

  @override
  void onClose() {
    userNameController.dispose();
    passWordController.dispose();
    userNameFocusNode.dispose();
    passWordFocusNode.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final userName = userNameController.text;
    final passWord = passWordController.text;
    if (userName.isEmpty) {
      showToast('请输入用户名');
      return;
    }

    if (passWord.isEmpty) {
      showToast('请输入密码');
      return;
    }

    userNameFocusNode.unfocus();
    passWordFocusNode.unfocus();

    try {
      await EasyLoading.show(status: '正在登录...');
      final res = await _loginRequest(userName: userName, passWord: passWord);
      await EasyLoading.dismiss();
      if (res != null && res.isSuccess) {
        unawaited(_gotoHomePage());
        await SpService.setString(SpKeys.userName, userName);
        await SpService.setString(SpKeys.passWord, passWord);
        showToast('登录成功');
        unawaited(saveWithExpirationDate());
      } else {
        showToast(res?.errorMessage ?? '登录失败');
      }
    } catch (e) {
      logger.info('登录失败: $e');
    }
  }

  /// 登录请求
  Future<ApiResponseModel?> _loginRequest({
    required String userName,
    required String passWord,
  }) {
    unawaited(SwitchOnModel.requestSwitchOn());

    return Http.post(
      Apis.login,
      data: {
        'loginName': userName,
        'password': passWord,
      },
    );
  }

  Future<void> saveWithExpirationDate() async {
    final expirationTime = DateTime.now().millisecondsSinceEpoch +
        30 * 24 * 60 * 60 * 1000; // 30天的毫秒数

    await SpService.setInt(SpKeys.loginInfoExpirationTime, expirationTime);
  }

  /// 是否过期
  bool get _isExpired {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final expirationTime =
        SpService.getInt(SpKeys.loginInfoExpirationTime) ?? 0;

    if (currentTime < expirationTime) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> _gotoHomePage() async {
    const tabBar = AppTabBar();
    await Get.offAll(tabBar);
  }

  void fixFocusNode(FocusNode focusNode) {
    _debounce(() {
      _fixFocusNodeDebounce(focusNode);
      _debounce.cancel();
    });
  }

  void _fixFocusNodeDebounce(FocusNode focusNode) {
    if (focusNode.hasFocus) return;
    FocusScope.of(Get.context!).requestFocus(focusNode);
  }

  set obscureText(bool obscureText) {
    _obscureText = obscureText;
    update([LOGIN_OBSCURE_TEXT_ID]);
  }

  bool get obscureText {
    return _obscureText;
  }
}
