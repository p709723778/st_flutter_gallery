import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

/// 记录仪生命周期状态设置应答
class RecorderLifeCycleSetRespModel extends BaseCommandFrameRespModel {
  RecorderLifeCycleSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  });

  static const int commandTypeRespTag = 0xE9;

  /// 0：成功  1：失败
  int get result {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }
}
