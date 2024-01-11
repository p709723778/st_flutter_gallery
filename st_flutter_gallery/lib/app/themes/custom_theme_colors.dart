import 'package:flutter/material.dart';

/// 此类是对 ThemeData 的扩展主题,添加自己自定义的主题
/// 在 themes.dart 中的 extensions 已经声明使用
@immutable
class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  const CustomThemeColors({this.testColor = Colors.white});

  final Color? testColor;

  @override
  ThemeExtension<CustomThemeColors> copyWith() {
    return CustomThemeColors(testColor: testColor);
  }

  @override
  ThemeExtension<CustomThemeColors> lerp(
    ThemeExtension<CustomThemeColors>? other,
    double t,
  ) {
    if (other is! CustomThemeColors) {
      return this;
    }
    return CustomThemeColors(
      testColor: Color.lerp(testColor, other.testColor, t),
    );
  }
}
