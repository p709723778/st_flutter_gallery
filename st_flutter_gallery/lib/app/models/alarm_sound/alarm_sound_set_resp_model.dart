import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

// 设置主动安全报警声音是否开启响应
class AlarmSoundSetRespModel extends BaseCommandFrameRespModel {
  AlarmSoundSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  });

  static const int commandTypeRespTag = 0xEE;

  /// 一个字节：
  // 0x0:设置成功
  // 0x1:设置失败
  int get result {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }
}
