import 'dart:convert';

import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

/// 平台IP端口设置
class PlatformIpSetReqModel extends BaseCommandFrameReqModel {
  PlatformIpSetReqModel({
    required super.dataBytes,
    super.commandType = 0x64,
    super.dataLength = 11,
  });

  static void test() {
    const tcp1 = 'TCP2:192.168.12.13,6008';
    const tcp2 = 'TCP2:192.168.12.13,6008';
    const tcp3 = 'TCP2:192.168.12.13,6008';

    const tcpList = '$tcp1 $tcp2 $tcp3 /\r/\n/\0';
    final bytes = utf8.encode(tcpList);

    final model = PlatformIpSetReqModel(dataBytes: bytes);
    model.commandFrame;
  }
}
