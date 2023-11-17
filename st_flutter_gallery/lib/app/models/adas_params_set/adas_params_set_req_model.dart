import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// ADAS参数下发标定
class AdasParamsSetReqModel extends BaseCommandFrameReqModel {
  AdasParamsSetReqModel({
    required super.dataBytes,
    super.commandType = 0x62,
    super.dataLength = 19,
  });

  static void test() {
    /// 车宽（mm）
    final yearByteData = ByteData(2)..setUint16(0, 10);

    /// 相机与车辆中心之间的距离(从驾驶室往外看，左正右负)（mm）
    final mouthByteData = ByteData(2)..setUint16(0, 20);

    /// 相机到前保险杠距离（mm）
    final dayByteData = ByteData(2)..setUint16(0, 30);

    /// 镜头和前轮胎之间距离（mm）
    final hourByteData = ByteData(2)..setUint16(0, 40);

    /// 相机距离地面高度（mm）
    final minuteByteData = ByteData(2)..setUint16(0, 50);

    final data = [
      ...yearByteData.buffer.asUint8List(),
      ...mouthByteData.buffer.asUint8List(),
      ...dayByteData.buffer.asUint8List(),
      ...hourByteData.buffer.asUint8List(),
      ...minuteByteData.buffer.asUint8List(),
    ];

    AdasParamsSetReqModel model = AdasParamsSetReqModel(dataBytes: data);
    model.commandFrame;
  }
}
