import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// BSD参数下发标定
class BSDParamsSetReqModel extends BaseCommandFrameReqModel {
  BSDParamsSetReqModel({
    required super.dataBytes,
    super.commandType = 0x61,
    super.dataLength = 19,
  });

  static void test() {
    /// 摄像头安装高度（mm）
    final yearByteData = ByteData(2)..setUint16(0, 10);

    /// 一级报警距离（mm）
    final mouthByteData = ByteData(2)..setUint16(0, 20);

    /// 二级报警距离（mm）
    final dayByteData = ByteData(2)..setUint16(0, 30);

    /// 三级报警距离（mm）
    final hourByteData = ByteData(2)..setUint16(0, 40);

    /// 前方报警距离（mm）
    final minuteByteData = ByteData(2)..setUint16(0, 50);

    final data = [
      ...yearByteData.buffer.asUint8List(),
      ...mouthByteData.buffer.asUint8List(),
      ...dayByteData.buffer.asUint8List(),
      ...hourByteData.buffer.asUint8List(),
      ...minuteByteData.buffer.asUint8List(),
    ];

    BSDParamsSetReqModel model = BSDParamsSetReqModel(dataBytes: data);
    model.commandFrame;
  }
}
