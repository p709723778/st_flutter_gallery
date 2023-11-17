import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 平台IP端口查询
class PlatformIpGetReqModel extends BaseCommandFrameReqModel {
  PlatformIpGetReqModel({
    super.dataBytes,
    super.commandType = 0x70,
    super.dataLength = 9,
  });
}
