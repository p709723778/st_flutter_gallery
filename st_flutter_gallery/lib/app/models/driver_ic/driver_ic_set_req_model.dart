import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// IC卡写入数据
class DriverIcSetReqModel extends BaseCommandFrameReqModel {
  DriverIcSetReqModel({
    required super.dataBytes,
    super.commandType = 0x6A,
    super.dataLength = 137,
  });

  static void test() {
    /// 预留
    final yearByteData = ByteData(32 - 1)..setUint16(0, 0);

    /// 机动驾驶证号码
    ///ASC II
    const driverNumbers = '4564654564564564';

    final driverNumbersByteData = Uint8List(50 - 33);
    final utf8Bytes = utf8.encode(driverNumbers);
    driverNumbersByteData.setRange(0, utf8Bytes.length, utf8Bytes);

    // final utf8Bytes2 = driverNumbers.codeUnits;
    // byteData.setRange(0, utf8Bytes2.length, utf8Bytes2);

    /// 姓名
    const driverName = '张三';

    final byteDataNameUint8List = Uint8List(82 - 51);
    final utf8BytesName = utf8.encode(driverName);
    byteDataNameUint8List.setRange(0, utf8BytesName.length, utf8BytesName);

    /// 标准扩展预留
    final yearByteData1 = ByteData(127 - 83)..setUint16(0, 0);

    final data = [
      ...yearByteData.buffer.asUint8List(),
      ...driverNumbersByteData.buffer.asUint8List(),
      ...byteDataNameUint8List.buffer.asUint8List(),
      ...yearByteData1.buffer.asUint8List(),
    ];

    final model = DriverIcSetReqModel(dataBytes: data);
    model.commandFrame;
  }
}
