import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 平台电话号码设置
class PhoneNumberSetReqModel extends BaseCommandFrameReqModel {
  PhoneNumberSetReqModel({
    required super.dataBytes,
    super.commandType = 0x65,
    super.dataLength = 19,
  });

  static void test() {
    var phoneNumber = "15818546283";
    const maxLength = 4;

    if (phoneNumber.length < maxLength) {
      phoneNumber = phoneNumber.padLeft(maxLength, '0');
    }

    /// 手机号不足位的，则在前补充0
    final byteData = ByteData(10)..setUint16(0, int.parse(phoneNumber));

    final byteDataU8List = byteData.buffer.asUint8List();

    final model2 = PhoneNumberSetReqModel(dataBytes: byteDataU8List);
  }
}
