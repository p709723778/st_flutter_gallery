import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 记录仪生命周期状态查询
class RecorderLifeCycleGetReqModel extends BaseCommandFrameReqModel {
  RecorderLifeCycleGetReqModel({
    super.dataBytes,
    super.commandType = 0x75,
    super.dataLength = 9,
  });
}
