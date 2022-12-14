import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/error_code/old_error_code.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/rsa/rsa_encrypt.dart';

class LoginPageController extends GetxController {
  late TextEditingController accountTextEditingController =
      TextEditingController();
  late TextEditingController passWordTextEditingController =
      TextEditingController();
  late FocusNode accountFocusNode = FocusNode();
  late FocusNode passWordFocusNode = FocusNode();
  bool _obscureText = true;

  int obscureTextId = 1;
  @override
  void onInit() {
    if (kDebugMode) {
      accountTextEditingController.text = 'cs';
      passWordTextEditingController.text = '111111';
    }
    super.onInit();
  }

  @override
  void onClose() {}

  set obscureText(bool obscureText) {
    _obscureText = obscureText;
    update([obscureTextId]);
  }

  bool get obscureText {
    return _obscureText;
  }

  Future<void> userLogin() async {
    if (accountTextEditingController.text.isEmpty) {
      showToast('请输入账号');
      return;
    }
    if (passWordTextEditingController.text.isEmpty) {
      showToast('请输入密码');
      return;
    }

    final userName = RSAEncrypt.encryption(accountTextEditingController.text);
    final passWord = RSAEncrypt.encryption(passWordTextEditingController.text);

    logger
      ..info('用户名 $userName')
      ..info('密码 $passWord');

    try {
      await EasyLoading.show(
        status: '正在登录...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.login,
        needOriginalData: true,
        queryParameters: {
          'username': userName,
          'pass': passWord,
        },
      );

      final isLoginSuccess =
          apiResponseModel?.response?.headers.value('login-success');
      final errMsg = apiResponseModel?.response?.headers.value('errmsg');

      if (isLoginSuccess == 'true') {
        unawaited(Get.offAllNamed(Routes.HOME));
      } else {
        showToast(errorCodeString(errMsg!));
      }
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
  }
}
