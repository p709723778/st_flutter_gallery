import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// 记录仪生命周期状态设置
class RecorderLifeCycleSetReqModel extends BaseCommandFrameReqModel {
  RecorderLifeCycleSetReqModel({
    required super.dataBytes,
    super.commandType = 0x69,
    super.dataLength = 10,
  });

  static void test() {
    // 一个字节
    // 00H： 芯片未进行密钥注入和信息初始化
    // 01H： 芯片出厂状态， 已配置记录仪编号
    // 02H： 记录仪生产（维修） 检验阶段
    // 03H： 记录仪生产（维修） 后出厂待装
    // 04H： 预安装状态， 可设置 VIN
    // 05H： 安装准备， 可设置 VIN、 车牌号
    // 06H： 安装自检
    // 08H： 正式运行状态
    // 0FH： 报废/退服状态

    final model = RecorderLifeCycleSetReqModel(
      dataBytes: [0],
    );
    model.commandFrame;
  }
}
