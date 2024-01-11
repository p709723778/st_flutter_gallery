import 'package:flutter/material.dart';
import 'package:st/app/themes/custom_theme_colors.dart';

const _stPrimaryColor = Color(0xFF198CFE);
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
  brightness: Brightness.light,
  primaryColor: _stPrimaryColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      color: Color(0xFF5C6273),
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  ),
  // 此处可以自定义多个自己的主题颜色类
  extensions: const <ThemeExtension<dynamic>>[
    CustomThemeColors(
      testColor: Colors.green,
    ),
  ],
);

/// 深色主题
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  extensions: const <ThemeExtension<dynamic>>[
    CustomThemeColors(
      testColor: Colors.amber,
    ),
  ],
);
