import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:st/app/models/user_info/user_info.dart';

class Global {
  /// 全局导航状态
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 登录用户信息
  static UserInfo loginUserInfo = UserInfo();

  /// 版本信息
  static PackageInfo? packageInfo;
}
