import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// D.12 数据摘要测试命令帧定义
class DataSummaryGetReqModel extends BaseCommandFrameReqModel {
  DataSummaryGetReqModel({
    required super.dataBytes,
    super.commandType = 0x58,
    super.dataLength = 15,
  });
}
