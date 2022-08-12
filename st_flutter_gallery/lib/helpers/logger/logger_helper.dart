import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:let_log/let_log.dart' as let_log;
import 'package:logging/logging.dart';
import 'package:st/config/env_config.dart';

final logger = Logger.root;
final wsLogger = Logger("ws");
final httpLogger = Logger("http");

class LoggerHelper {
  static void initLogger() {
    if (!kDebugMode && !EnvConfig.isDebug) {
      Get.isLogEnable = false;
      logger.level = Level.OFF;
      return;
    }

    logger.level = Level.ALL;
    logger.onRecord.listen((record) {
      switch (record.level.name) {
        case "WARNING":
          let_log.Logger.warn(record.message);
          break;
        case "SEVERE":
          let_log.Logger.error(record.message, record.error);
          break;
        default:
          let_log.Logger.log(record.message);
          break;
      }
      if (record.error != null) logger.severe(record.error.toString());
      logger.info(record.message);
    });
  }
}
