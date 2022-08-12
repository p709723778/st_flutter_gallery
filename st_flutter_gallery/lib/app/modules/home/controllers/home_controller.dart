import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class HomeController extends GetxController {
  HomeController({this.context});

  final count = 0.obs;
  late final BuildContext? context;

  @override
  void onInit() {
    super.onInit();
    logger.info('onInit');
  }

  @override
  void onReady() {
    super.onReady();
    logger.info('onReady');
  }

  @override
  void onClose() {}
  void increment() {
    count.value++;
  }
}
