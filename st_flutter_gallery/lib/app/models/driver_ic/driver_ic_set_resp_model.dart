import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

// IC卡写入数据应答
class DriverIcSetRespModel extends BaseCommandFrameRespModel {
  DriverIcSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  }) {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    result = dataBytesByteData.getUint8(0);
  }

  static const int commandTypeRespTag = 0xEA;

  int? result;
}
