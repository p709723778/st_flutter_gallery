import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 查询速度类型
class SpeedTypeGetReqModel extends BaseCommandFrameReqModel {
  SpeedTypeGetReqModel({
    super.dataBytes,
    super.commandType = 0x78,
    super.dataLength = 9,
  });
}
