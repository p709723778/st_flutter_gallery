import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/lang/translation/en_US.dart';
import 'package:st/app/lang/translation/zh_CN.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('zh', 'Hans');

  @override
  Map<String, Map<String, String>> get keys {
    return {
      'zh_CN': zh_CN,
      'en_US': en_US,
    };
  }

  static void changeLocale() {
    Get.updateLocale(const Locale('en', 'US'));
  }
}
