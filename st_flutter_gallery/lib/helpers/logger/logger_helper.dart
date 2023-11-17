import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:let_log/let_log.dart' as let_log;
import 'package:logging/logging.dart';
import 'package:st/config/env_config.dart';

final logger = Logger.root;
final wsLogger = Logger("ws");
final httpLogger = Logger("http");

StreamSubscription? _logSubscription;

void initLogger() {
  if (!kDebugMode && !EnvConfig.isDebug) {
    Get.isLogEnable = false;
    logger.level = Level.OFF;
    _logSubscription?.cancel();
    return;
  }
  Get.isLogEnable = true;
  logger.level = Level.ALL;
  _logSubscription?.cancel();
  logger.onRecord.listen((record) {
    switch (record.level.name) {
      case "WARNING":
        let_log.Logger.warn(record.message);
        break;
      case "SEVERE":
        let_log.Logger.error(record.message, record.error);
        break;
      default:
        let_log.Logger.debug(record.message);
        break;
    }
    // if (kDebugMode) {
    //   if (record.error != null) print("Logger ${record.error.toString()}");
    //   print("Logger ${record.message}");
    // }
  });
}

class LoggerHelper {
  static void log(String text, {bool isError = false}) {
    Future.microtask(() {
      if (isError && Get.isLogEnable) {
        logger.info('[GetX] ** $text. isError: [$isError]');
      }
    });
  }
}
