import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

class Apn4gSetReqModel extends BaseCommandFrameReqModel {
  Apn4gSetReqModel({
    required super.dataBytes,
    super.commandType = 0x6F,
    super.dataLength = 0,
  });
}
