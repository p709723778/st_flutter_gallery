import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

class AlarmSoundGetReqModel extends BaseCommandFrameReqModel {
  AlarmSoundGetReqModel({
    required super.dataBytes,
    super.commandType = 0x79,
    super.dataLength = 10,
  });
}
