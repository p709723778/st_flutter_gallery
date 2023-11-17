import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestCodePageController extends GetxController {
  TestCodePageController({this.context});

  late final BuildContext? context;
  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
