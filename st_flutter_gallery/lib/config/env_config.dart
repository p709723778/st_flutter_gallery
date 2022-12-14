import 'dart:io';

import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/services/sp_service/sp_service.dart';

enum Env {
  /// 开发环境
  dev,

  /// 沙盒环境
  sandbox,

  ///预发布环境
  pre,

  /// 正式环境
  pro,
}

class EnvConfig {
  /// 是否是调试模式，调试模式会打印一些日志，release模式下，isDebug会自动改为false
  static bool isDebug = false;

  /// 当前服务器环境
  static Env env = Env.pro;

  /// 是否使用https
  static bool useHttps = false;

  /// 协议头
  static String get httpScheme => useHttps ? 'https://' : 'http://';

  /// 服务器地址
  static String get baseUrl {
    final host = _hosts[env];
    final baseUrl = '$httpScheme$host';

    final baseUri = Uri.parse(baseUrl);

    return baseUri.toString();
  }

  static const Map _hosts = {
    Env.dev: "219.144.185.121:11380",
    Env.sandbox: "219.144.185.121:11380",
    Env.pre: "219.144.185.121:11380",
    Env.pro: "219.144.185.121:11380",
    // Env.dev: "wnsykj.drillass.com",
    // Env.sandbox: "wnsykj.drillass.com",
    // Env.pre: "wnsykj.drillass.com",
    // Env.pro: "wnsykj.drillass.com",
  };

  static Future<void> initEnvConfig() async {
    // 提前获取环境，之前Engine/init/env有点滞后
    final savedEnvVar = SpService.getInt(SpKeys.networkEnvShared);
    if (savedEnvVar != null) {
      EnvConfig.env = Env.values[savedEnvVar];
    } else if (EnvConfig.isDebug) {
      EnvConfig.env = Env.dev;
    }
  }

  static void setEnv(Env env) {
    SpService.setInt(SpKeys.networkEnvShared, env.index);
    showToast('网络环境已设置为 @环境，重启后生效'.trParams({'环境': envConvertString(env)}));
    Future.delayed(3.seconds, exit(0));
  }

  static String envConvertString(Env env) {
    final String envString;
    switch (env) {
      case Env.dev:
        envString = '开发环境'.tr;
        break;
      case Env.sandbox:
        envString = '沙盒环境'.tr;
        break;
      case Env.pre:
        envString = '预发环境'.tr;
        break;
      case Env.pro:
        envString = '正式环境'.tr;
        break;
    }
    return envString;
  }
}
