import 'package:flutter/material.dart';
import 'package:st/utils/colors/colors_util.dart';

class CommonWidgetModel {
  CommonWidgetModel({
    required this.icon,
    this.title = '',
    this.subTitle = '',
    this.color,
    this.des = '',
  }) {
    // 具体初始化代码
    color ??= ColorsUtil.randomColor();
  }

  final IconData icon;
  final String title;
  final String subTitle;
  final String des;
  Color? color;
}
