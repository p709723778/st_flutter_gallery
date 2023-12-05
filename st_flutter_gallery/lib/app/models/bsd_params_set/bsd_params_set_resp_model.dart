// 在Flutter中，可以使用`Uint8List`类型来表示一个4x4字节的矩形。`Uint8List`是一个无符号8位整数列表，用于表示字节数据。
//
// 以下是一个示例，演示了如何使用`Uint8List`来表示一个4x4字节的矩形：
//
// ```dart
// import 'dart:typed_data';
//
// void main() {
// Uint8List rectangle = Uint8List(16);
//
// rectangle[0] = 10;
// rectangle[1] = 20;
// rectangle[2] = 30;
// rectangle[3] = 40;
//
// rectangle[4] = 50;
// rectangle[5] = 60;
// rectangle[6] = 70;
// rectangle[7] = 80;
//
// rectangle[8] = 90;
// rectangle[9] = 100;
// rectangle[10] = 110;
// rectangle[11] = 120;
//
// rectangle[12] = 130;
// rectangle[13] = 140;
// rectangle[14] = 150;
// rectangle[15] = 160;
//
// print(rectangle); // 输出结果：[10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160]
// }
// ```
//
// 在上面的示例中，我们创建了一个长度为16的`Uint8List`对象，每个元素代表一个字节。通过指定索引，我们将值存储到列表中，以表示一个4x4字节的矩形。
//
// 请注意，这只是一个示例，你可以根据自己的需求自定义矩形的字节数据。每个字节的范围是0到255。

import 'dart:typed_data';
import 'dart:ui';

import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

/// BSD参数下发标定应答
class BSDParamsSetRespModel extends BaseCommandFrameRespModel {
  BSDParamsSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 59,
  });

  static const int commandTypeRespTag = 0xE1;

  final rectangleA = [];

  /// 0：成功  1：失败
  int get result {
    final data = respDataBytes.sublist(8, 8 + 1);
    final result = data[0];
    return result;
  }

  int get coordinateType {
    final data = respDataBytes.sublist(9, 9 + 1);
    final result = data[0];
    return result;
  }

  List<Offset> getRectangleA() {
    final rectangleData = respDataBytes.sublist(10, dataLengthResp - 1);

    final a1X = Uint8List.fromList(rectangleData.sublist(0, 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final a1Y = Uint8List.fromList(rectangleData.sublist(2, 2 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final a2X = Uint8List.fromList(rectangleData.sublist(4, 4 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final a2Y = Uint8List.fromList(rectangleData.sublist(6, 6 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final a3X = Uint8List.fromList(rectangleData.sublist(8, 8 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final a3Y = Uint8List.fromList(rectangleData.sublist(10, 10 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final a4X = Uint8List.fromList(rectangleData.sublist(12, 12 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final a4Y = Uint8List.fromList(rectangleData.sublist(14, 14 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final list = [
      Offset(a1X.toDouble(), a1Y.toDouble()),
      Offset(a2X.toDouble(), a2Y.toDouble()),
      Offset(a3X.toDouble(), a3Y.toDouble()),
      Offset(a4X.toDouble(), a4Y.toDouble()),
    ];
    return list;
  }

  List<Offset> getRectangleB() {
    final rectangleData = respDataBytes.sublist(10, dataLengthResp - 1);

    final b1X = Uint8List.fromList(rectangleData.sublist(16, 16 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final b1Y = Uint8List.fromList(rectangleData.sublist(18, 18 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final b2X = Uint8List.fromList(rectangleData.sublist(20, 20 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final b2Y = Uint8List.fromList(rectangleData.sublist(22, 22 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final b3X = Uint8List.fromList(rectangleData.sublist(24, 24 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final b3Y = Uint8List.fromList(rectangleData.sublist(26, 26 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final b4X = Uint8List.fromList(rectangleData.sublist(28, 28 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final b4Y = Uint8List.fromList(rectangleData.sublist(30, 30 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final list = [
      Offset(b1X.toDouble(), b1Y.toDouble()),
      Offset(b2X.toDouble(), b2Y.toDouble()),
      Offset(b3X.toDouble(), b3Y.toDouble()),
      Offset(b4X.toDouble(), b4Y.toDouble()),
    ];
    return list;
  }

  List<Offset> getRectangleC() {
    final rectangleData = respDataBytes.sublist(10, dataLengthResp - 1);

    final c1X = Uint8List.fromList(rectangleData.sublist(32, 32 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final c1Y = Uint8List.fromList(rectangleData.sublist(34, 34 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final c2X = Uint8List.fromList(rectangleData.sublist(36, 36 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final c2Y = Uint8List.fromList(rectangleData.sublist(38, 38 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final c3X = Uint8List.fromList(rectangleData.sublist(40, 40 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final c3Y = Uint8List.fromList(rectangleData.sublist(42, 42 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final c4X = Uint8List.fromList(rectangleData.sublist(44, 44 + 2))
        .buffer
        .asByteData()
        .getUint16(0);
    final c4Y = Uint8List.fromList(rectangleData.sublist(46, 46 + 2))
        .buffer
        .asByteData()
        .getUint16(0);

    final list = [
      Offset(c1X.toDouble(), c1Y.toDouble()),
      Offset(c2X.toDouble(), c2Y.toDouble()),
      Offset(c3X.toDouble(), c3Y.toDouble()),
      Offset(c4X.toDouble(), c4Y.toDouble()),
    ];
    return list;
  }
}
