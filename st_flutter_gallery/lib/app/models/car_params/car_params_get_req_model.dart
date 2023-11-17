import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 车辆参数信息查询
class CarParamsGetReqModel extends BaseCommandFrameReqModel {
  CarParamsGetReqModel({
    super.dataBytes,
    super.commandType = 0x72,
    super.dataLength = 9,
  });

  static void test() {
    final model = CarParamsGetReqModel(dataBytes: []);
    model.commandFrame;
  }
}
