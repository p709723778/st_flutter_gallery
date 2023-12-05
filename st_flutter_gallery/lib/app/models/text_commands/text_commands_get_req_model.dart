import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

class TextCommandsGetReqModel extends BaseCommandFrameReqModel {
  TextCommandsGetReqModel({
    super.dataBytes,
    super.commandType = 0x7B,
    super.dataLength = 0,
  });
}
