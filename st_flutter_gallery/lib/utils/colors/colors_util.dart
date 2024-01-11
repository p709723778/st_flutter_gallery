import 'dart:math';

import 'package:flutter/material.dart';

class ColorsUtil {
  /// 随机颜色
  static Color randomColor() {
    return Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );
  }
}
