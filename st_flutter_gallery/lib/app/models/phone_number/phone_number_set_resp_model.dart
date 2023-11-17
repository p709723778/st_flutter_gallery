import 'dart:typed_data';

import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

// final model1 = PhoneNumberSetRespModel(
//   respDataBytes: [
//     0x57,
//     0x78,
//     0xE5,
//     0x00,
//     0x0a,
//     0x00,
//     0x00,
//     0x00,
//     0x02,
//     0x66,
//   ],
// );
// final result = model2.getResult();
//
// final ok = model2.isValid();

class PhoneNumberSetRespModel extends BaseCommandFrameRespModel {
  PhoneNumberSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  });

  static const int commandTypeRespTag = 0xE5;

  /// 0：成功  1：失败
  int get result {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }
}
