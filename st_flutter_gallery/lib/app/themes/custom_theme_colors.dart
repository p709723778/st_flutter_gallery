import 'package:flutter/material.dart';

/// 此类是对 ThemeData 的扩展主题,添加自己自定义的主题
/// 在 themes.dart 中的 extensions 已经声明使用
@immutable
class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  const CustomThemeColors({
    this.testColor = Colors.white,
    this.tabBarBackgroundColor,
    this.dangerColor,
    this.backgroundColor,
    this.timeLineColor,
  });

  final Color? testColor;

  final Color? tabBarBackgroundColor;

  final Color? dangerColor;

  final Color? backgroundColor;

  final Color? timeLineColor;

  @override
  ThemeExtension<CustomThemeColors> copyWith() {
    return CustomThemeColors(
      testColor: testColor,
      tabBarBackgroundColor: tabBarBackgroundColor,
      dangerColor: dangerColor,
      backgroundColor: backgroundColor,
      timeLineColor: timeLineColor,
    );
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
      tabBarBackgroundColor:
          Color.lerp(tabBarBackgroundColor, other.tabBarBackgroundColor, t),
      dangerColor: Color.lerp(dangerColor, other.dangerColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      timeLineColor: Color.lerp(timeLineColor, other.timeLineColor, t),
    );
  }
}
