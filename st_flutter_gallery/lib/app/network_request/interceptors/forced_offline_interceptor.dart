import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:oktoast/oktoast.dart';
import 'package:st/app/network_request/cookie_jar_manager/cookie_jar_manager.dart';
import 'package:st/app/routes/app_pages.dart';

class ForcedOfflineInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 302) {
      logout();
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 302) {
      logout();
    }
    super.onResponse(response, handler);
  }

  void logout() {
    if (getx.Get.currentRoute != Routes.LOGIN_PAGE) {
      CookieJarManager.deleteCookie();
      unawaited(
        getx.Get.offAllNamed(Routes.LOGIN_PAGE),
      );
      showToast('您的账户已在其他设备登录，若非本人操作，请修改密码或联系管理员处理', duration: 4.seconds);
    }
  }
}
