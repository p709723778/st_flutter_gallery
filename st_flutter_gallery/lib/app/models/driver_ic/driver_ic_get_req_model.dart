import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

/// IC 卡读取
class DriverIcGetReqModel extends BaseCommandFrameReqModel {
  DriverIcGetReqModel({
    required super.dataBytes,
    super.commandType = 0x77,
    super.dataLength = 9,
  });
}
