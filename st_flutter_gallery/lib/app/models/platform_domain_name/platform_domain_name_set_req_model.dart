import 'dart:convert';

import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 设置平台域名
class PlatformDomainNameSetReqModel extends BaseCommandFrameReqModel {
  PlatformDomainNameSetReqModel({
    required super.dataBytes,
    super.commandType = 0x6B,
    super.dataLength = 0x00,
  });

  static void test() {
    // 设置多路请重复发送
    const tcp1 = 'TDevice.1.com,7008';
    // const tcp2 = 'tDevice.2.com,7008';
    // const tcp3 = 'sDevice.3.com,7008';

    final bytes = utf8.encode(tcp1);

    final model = PlatformDomainNameSetReqModel(dataBytes: bytes);
    model.commandFrame;
  }
}
