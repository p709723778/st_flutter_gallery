import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

class AlarmSoundGetRespModel extends BaseCommandFrameRespModel {
  AlarmSoundGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  });

  static const int commandTypeRespTag = 0xF9;

  // 一个字节：
  // 0x1:开启
  // 0x2:关闭
  int get state {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }
}
