import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

class Apn4gGetReqModel extends BaseCommandFrameReqModel {
  Apn4gGetReqModel({
    required super.dataBytes,
    super.commandType = 0x7A,
    super.dataLength = 9,
  });
}
