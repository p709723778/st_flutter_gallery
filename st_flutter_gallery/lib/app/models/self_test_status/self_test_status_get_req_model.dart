// 获取安装自检状态
//
// （安装人员通过APP配置完成后，可以通过此命令自检，设备返回自检状态，APP展示自检结果或相关异常的项目）
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 获取安装自检状态
//
// （安装人员通过APP配置完成后，可以通过此命令自检，设备返回自检状态，APP展示自检结果或相关异常的项目）

class SelfTestStatusGetReqModel extends BaseCommandFrameReqModel {
  SelfTestStatusGetReqModel({
    super.dataBytes = const [],
    super.commandType = 0x6D,
    super.dataLength = 9,
  });

  static void test() {
    final model = SelfTestStatusGetReqModel(dataBytes: []);
    model.commandFrame;
  }
}
