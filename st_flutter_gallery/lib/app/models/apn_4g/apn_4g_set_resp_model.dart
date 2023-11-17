import 'dart:typed_data';

import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

class Apn4gSetRespModel extends BaseCommandFrameRespModel {
  Apn4gSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
  });

  static const int commandTypeRespTag = 0xEF;

  /// 0：成功  1：失败
  int get result {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }
}
