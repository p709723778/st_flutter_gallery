import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/home/models/common_widget_model.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class HomeController extends GetxController {
  HomeController({this.context});

  final count = 0.obs;
  late final BuildContext? context;
  final List gridViewDataSource = [];

  @override
  void onInit() {
    super.onInit();
    gridViewDataSource
      ..add(
        CommonWidgetModel(
          icon: Icons.tab_unselected_outlined,
          title: 'Container',
          subTitle: '容器组件',
          color: Colors.cyan,
        ),
      )
      ..add(
        CommonWidgetModel(
          icon: Icons.text_fields,
          title: 'Text',
          subTitle: '文本组件',
          color: Colors.deepPurple,
        ),
      );
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
    update();
  }
}
