import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

//  一个字节
//  Bit0:唯一性编码状态
//  Bit1::vin状态
//  BIT2：速度信号状态
//  Bit3:定位状态
//  BIT4:开关量状态
//  BIT5~BIT7 保留
//  每个bit位=1 表示正常； =0表示自检异常。

class SelfTestStatusGetRespModel extends BaseCommandFrameRespModel {
  SelfTestStatusGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  }) {
    final data = respDataBytes.sublist(8, 8 + 1);
    state = Uint8List.fromList(data).buffer.asByteData().getUint8(0);
  }

  static const int commandTypeRespTag = 0xED;

  int state = 0xFF;
}
