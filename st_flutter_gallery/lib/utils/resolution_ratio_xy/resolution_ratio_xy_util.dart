import 'dart:ui';

import 'package:st/app/constants/number_key.dart';

enum VideoResolutionRatioType {
  P720(0, 1280, 720), // 1280X720
  P1080(1, 1920, 1080); // 1920X1080

  const VideoResolutionRatioType(this.value, this.width, this.height);

  final int value;
  final double width;
  final double height;

  static VideoResolutionRatioType fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => VideoResolutionRatioType.P720,
    );
  }
}

class ResolutionRatioUtil {
  /// 根据视频分辨率xy坐标转换为实际视图的xy坐标
  static Offset convertXY({
    required VideoResolutionRatioType type,
    required Offset offset,
    double? viewWidth,
    double? viewHeight,
    required Size size,
  }) {
    final videoWidth = type.width;
    final videoHeight = type.height;
    final newWidth = viewWidth ?? size.width;
    final newHeight = viewHeight ?? size.height;

    final oldX = offset.dx;
    final oldY = offset.dy;

    final newX = (oldX * newWidth / videoWidth).round();
    final newY = (oldY * newHeight / videoHeight).round();

    return Offset(newX.toDouble(), newY.toDouble());
  }

  static int convertHeight({required int viewWidth}) {
    final newHeight = viewWidth / aspectRatio_H;
    return newHeight.round();
  }
}
