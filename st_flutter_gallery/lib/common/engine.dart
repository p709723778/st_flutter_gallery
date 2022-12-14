import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Engine {
  static WidgetsBinding? _widgetsBinding;

  /// 在[allowRender]之前, flutter engine将不会任何渲染frame，但在启动时，原生闪屏
  /// 界面不受影响
  static void deferRender(WidgetsBinding widgetsBinding) {
    if (!GetPlatform.isMobile) return;
    _widgetsBinding = widgetsBinding;
    _widgetsBinding?.deferFirstFrame();
  }

  /// 通知framework可让engine渲染frame了
  static void allowRender() {
    if (!GetPlatform.isMobile) return;
    _widgetsBinding?.allowFirstFrame();
    _widgetsBinding = null;
  }
}
