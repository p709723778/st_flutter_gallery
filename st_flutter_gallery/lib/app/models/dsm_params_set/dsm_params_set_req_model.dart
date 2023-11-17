import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// DSM参数下发标定
class DsmParamsSetReqModel extends BaseCommandFrameReqModel {
  DsmParamsSetReqModel({
    required super.dataBytes,
    super.commandType = 0x63,
    super.dataLength = 11,
  });

  static void test() {
    /// 偏转角（左正右负单位度）
    const yearByteData = 1;

    /// 2.俯仰角（上正下负单位度）
    const mouthByteData = 2;

    final data = [
      yearByteData,
      mouthByteData,
    ];

    DsmParamsSetReqModel model = DsmParamsSetReqModel(dataBytes: data);
    model.commandFrame;
  }
}
