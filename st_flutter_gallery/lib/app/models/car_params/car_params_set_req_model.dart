// 车辆参数信息设置
import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

class CarParamsSetReqModel extends BaseCommandFrameReqModel {
  CarParamsSetReqModel({
    required super.dataBytes,
    super.commandType = 0x66,
    super.dataLength = 125,
  });

  static void test() {
    /// 省域ID(U_16)
    final yearByteData = ByteData(2)..setUint16(0, 1);

    /// 市域ID（U_16）
    final mouthByteData = ByteData(2)..setUint16(0, 2);

    /// 制造商ID（BYTE[11]）
    final dayByteData = ByteData(11)..setUint16(0, 30);

    /// 终端型号（BYTE[30]）
    final hourByteData = ByteData(30)..setUint16(0, 40);

    /// 终端ID（BYTE[30]）
    final minuteByteData = ByteData(30)..setUint16(0, 50);

    /// 车牌颜色（BYTE）
    final minuteByteData1 = ByteData(1)..setUint16(0, 50);

    /// 车牌号（BYTE[40]）GBK
    final minuteByteData2 = ByteData(40)..setUint16(0, 50);

    final data = [
      ...yearByteData.buffer.asUint8List(),
      ...mouthByteData.buffer.asUint8List(),
      ...dayByteData.buffer.asUint8List(),
      ...hourByteData.buffer.asUint8List(),
      ...minuteByteData.buffer.asUint8List(),
      ...minuteByteData1.buffer.asUint8List(),
      ...minuteByteData2.buffer.asUint8List(),
    ];

    final model = CarParamsSetReqModel(dataBytes: data);
    model.commandFrame;
  }
}
