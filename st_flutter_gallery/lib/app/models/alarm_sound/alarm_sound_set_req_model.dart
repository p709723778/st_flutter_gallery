import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 设置主动安全报警声音是否开启
class AlarmSoundSetReqModel extends BaseCommandFrameReqModel {
  AlarmSoundSetReqModel({
    required super.dataBytes,
    super.commandType = 0x6E,
    super.dataLength = 10,
  });
}
