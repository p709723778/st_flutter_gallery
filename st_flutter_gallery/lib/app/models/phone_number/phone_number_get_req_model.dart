import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 平台电话号码查询
class PhoneNumberGetReqModel extends BaseCommandFrameReqModel {
  PhoneNumberGetReqModel({
    required super.dataBytes,
    super.commandType = 0x71,
    super.dataLength = 9,
  });

  static void test() {
    final model = PhoneNumberGetReqModel(dataBytes: []);
    model.commandFrame;
  }
}
