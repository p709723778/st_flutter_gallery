import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 平台电话号码设置
class PhoneNumberSetReqModel extends BaseCommandFrameReqModel {
  PhoneNumberSetReqModel({
    required super.dataBytes,
    super.commandType = 0x65,
    super.dataLength = 19,
  });
}
