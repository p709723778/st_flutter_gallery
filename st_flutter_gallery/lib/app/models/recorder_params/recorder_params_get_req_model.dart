import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';
import 'package:st/utils/list/list_util.dart';

// 采集记录仪信息命令帧定义
class RecorderParamsGetReqModel extends BaseCommandFrameReqModel {
  RecorderParamsGetReqModel({
    required super.dataBytes,
    super.commandType = 0x31,
    super.dataLength = 33,
  });

  static void sendMessage() {
    /// 执行标准版本号
    final executeVersion = ByteData(1)..setUint8(0, 21);

    /// 执行标准修改单号
    final executeOrderId = ByteData(1)..setUint8(0, 0);

    /// 通讯机时间
    final deviceDate = BcdDataUtil.getDeviceDateTimeBcdBytes();

    /// 通讯机设备名称
    const deviceName = '名称';

    final deviceNameUtf8Bytes =
        ListUtil.fixedLenList(utf8.encode(deviceName), length: 16);

    // final deviceNameBytes = ByteData(16)..setUint16(0, 0);

    final data = [
      ...executeVersion.buffer.asUint8List(),
      ...executeOrderId.buffer.asUint8List(),
      ...deviceDate,
      ...deviceNameUtf8Bytes,
    ];

    final model = RecorderParamsGetReqModel(dataBytes: data);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }
}
