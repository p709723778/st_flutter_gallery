import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';

// D.12 数据摘要测试命令帧定义
class DataSummaryGetReqModel extends BaseCommandFrameReqModel {
  DataSummaryGetReqModel({
    required super.dataBytes,
    super.commandType = 0x58,
    super.dataLength = 15,
  });

  static void test() {
    const year = 2023;
    const mouth = 10;
    const day = 16;
    const hour = 21;
    const minute = 55;
    const seconds = 44;

    final yearByteData = ByteData(2)..setUint16(0, year);
    final mouthByteData = ByteData(2)..setUint16(0, mouth);
    final dayByteData = ByteData(2)..setUint16(0, day);
    final hourByteData = ByteData(2)..setUint16(0, hour);
    final minuteByteData = ByteData(2)..setUint16(0, minute);
    final secondsByteData = ByteData(2)..setUint16(0, seconds);

    final data = [
      ...yearByteData.buffer.asUint8List(),
      ...mouthByteData.buffer.asUint8List(),
      ...dayByteData.buffer.asUint8List(),
      ...hourByteData.buffer.asUint8List(),
      ...minuteByteData.buffer.asUint8List(),
      ...secondsByteData.buffer.asUint8List(),
    ];

    final deviceDateBytes = BcdDataUtil.getDeviceDateTimeBcdBytes();

    /// 通讯机时间
    DataSummaryGetReqModel model =
        DataSummaryGetReqModel(dataBytes: deviceDateBytes);
  }
}
