import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shake/shake.dart';
import 'package:st/app/manager/area_city/area_city_manager.dart';
import 'package:st/common/global.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/debug_settings/debug_settings_view.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/services/sp_service/sp_service.dart';

class ServicesManager {
  static Future<void> initServices() async {
    Global.packageInfo = await PackageInfo.fromPlatform();
    await Get.putAsync(() => SpService().init());
    initLogger();
    await EnvConfig.initEnvConfig();

    /******** 分割线以上需要先初始化 ********/

    if (GetPlatform.isMobile) {
      ShakeDetector.autoStart(onPhoneShake: DebugSettingsPage.show);
    } else if (GetPlatform.isDesktop && kDebugMode) {
      HardwareKeyboard.instance.addHandler((event) {
        if (event.logicalKey == LogicalKeyboardKey.f12 &&
            event is KeyDownEvent) {
          DebugSettingsPage.show();
        }
        return true;
      });
    }

    unawaited(AreaCityManager.instance.getAreaCityData());
    logger
      ..info('版本号: ${Global.packageInfo?.version}')
      ..info('buildNumber: ${Global.packageInfo?.buildNumber}');
  }
}
