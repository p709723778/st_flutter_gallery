import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

const int flag1 = 0x01;
const int flag2 = 0x02;
const int flag3 = 0x04;
const int flag4 = 0x08;
const int flag5 = 0x10;
const int flag6 = 0x20;
const int flag7 = 0x40;
const int flag8 = 0x80;

class RecorderParamsSetReqModel extends BaseCommandFrameReqModel {
  RecorderParamsSetReqModel({
    required super.dataBytes,
    super.commandType = 0x41,
    super.dataLength = 122,
  });
}
