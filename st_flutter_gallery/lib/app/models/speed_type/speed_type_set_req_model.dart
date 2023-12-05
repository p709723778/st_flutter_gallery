import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 设置速度类型
class SpeedTypeSetReqModel extends BaseCommandFrameReqModel {
  SpeedTypeSetReqModel({
    required super.dataBytes,
    super.commandType = 0x6C,
    super.dataLength = 10,
  });
}
