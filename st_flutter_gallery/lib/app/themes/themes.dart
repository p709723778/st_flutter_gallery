import 'package:flutter/material.dart';
import 'package:st/app/themes/custom_theme_colors.dart';

const _stPrimaryColor = Color(0xFF363A59);
final _primarySwatch = MaterialColor(
  _stPrimaryColor.value,
  const <int, Color>{
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: _stPrimaryColor,
    600: Color(0xFFE53935),
    700: Color(0xFFD32F2F),
    800: Color(0xFF1452CC),
    900: Color(0xFFB71C1C),
  },
);

/// 浅色主题
final ThemeData lightTheme = ThemeData(
  primarySwatch: _primarySwatch,
  brightness: Brightness.light,
  primaryColor: _stPrimaryColor,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: const Color(0xFFE6E8F0),
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFFB62424),
    unselectedLabelColor: Color(0xFF696C78),
    unselectedLabelStyle: TextStyle(fontSize: 10),
    labelStyle: TextStyle(fontSize: 10),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 18, color: _stPrimaryColor),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(color: _stPrimaryColor, fontSize: 22),
    // headline2 仅定义颜色值，用在页面上较灰色的文字展示
    headline2: TextStyle(color: _stPrimaryColor),
    bodyText1: TextStyle(color: _stPrimaryColor, fontSize: 18),
    bodyText2: TextStyle(color: Color(0xFF101F30), fontSize: 14),
    subtitle1: TextStyle(color: Color(0xFF696C78), fontSize: 14, height: 1.25),
    caption: TextStyle(color: Color(0xFFBAC5DB), fontSize: 12),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        const Color(0xFF363A59),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
      backgroundColor: MaterialStateProperty.all(const Color(0xFF363A59)),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 14),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        const Color(0xFF363A59),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 14),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      side: MaterialStateProperty.all(
        const BorderSide(color: Color(0xFF363A59)),
      ),
    ),
  ),
  dividerColor: const Color(0xFFE6E6E8),
  shadowColor: const Color(0xFF06223E).withOpacity(0.1),
  // 此处可以自定义多个自己的主题颜色类
  extensions: const <ThemeExtension<dynamic>>[
    CustomThemeColors(
      testColor: Colors.green,
      tabBarBackgroundColor: Colors.white,
      dangerColor: Color(0xFFB62424),
      backgroundColor: Color(0xFFF3F3F3),
      timeLineColor: Color(0xFF2EAF74),
    ),
  ],
);

/// 深色主题
final ThemeData darkTheme = lightTheme;
