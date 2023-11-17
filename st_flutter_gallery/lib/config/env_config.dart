import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/services/sp_service/sp_service.dart';

enum Env {
  /// 开发环境
  dev(0, '开发环境'),

  /// 沙盒环境
  sandbox(1, '沙盒环境'),

  ///预发布环境
  pre(2, '预发环境'),

  /// 正式环境
  pro(3, '正式环境'),

  /// 自定义
  custom(4, '自定义环境');

  const Env(this.value, this.title);

  final int value;
  final String title;

  static Env fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => Env.dev,
    );
  }
}

class EnvConfig {
  static bool isBuildPackage = !kDebugMode;

  /// 是否是调试模式，调试模式会打印一些日志，release模式下，isDebug会自动改为false
  static bool isDebug = false;

  /// 当前服务器环境
  static Env env = Env.pro;

  /// 是否使用https
  static bool useHttps = false;

  /// 是否使用哀悼灰色
  static bool isLamentGrey = false;

  /// 是否使用https
  static ValueNotifier<bool> isEnableUME = ValueNotifier(false);

  /// 协议头
  static String get httpScheme => useHttps ? 'https://' : 'http://';

  /// 服务器地址
  static String get baseUrl {
    var baseUrl = '';
    if (env == Env.custom) {
      baseUrl = '$httpScheme${getEnvCustomUrl()}';
    } else {
      final host = _hosts[env];
      baseUrl = '$httpScheme$host';
    }

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
    useHttps = SpService.getBool(
      SpKeys.isUseHttps,
    )!;

    isLamentGrey = SpService.getBool(
      SpKeys.isLamentGrey,
    )!;

    // 提前获取环境，之前Engine/init/env有点滞后
    final savedEnvVar = SpService.getInt(SpKeys.networkEnvShared);
    if (savedEnvVar != null) {
      EnvConfig.env = Env.values[savedEnvVar];
    } else if (EnvConfig.isDebug) {
      EnvConfig.env = Env.dev;
    }
  }

  static void setEnv(Env env) {
    EnvConfig.env = env;
    SpService.setInt(SpKeys.networkEnvShared, env.index);
    showToast('网络环境已设置为 @环境，重启后生效'.trParams({'环境': env.title}));
    // Future.delayed(3.seconds, exit(0));
  }

  static void setEnvCustom(Env env, {required String url}) {
    SpService.setString(SpKeys.networkEnvCustom, url);
    setEnv(env);
  }

  static String getEnvCustomUrl() {
    return SpService.getString(SpKeys.networkEnvCustom) ?? '';
  }
}
