import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

// 车辆参数信息设置应答
class CarParamsSetRespModel extends BaseCommandFrameRespModel {
  CarParamsSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  });

  static const int commandTypeRespTag = 0xE6;

  /// 0：成功  1：失败
  int get result {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }
}
