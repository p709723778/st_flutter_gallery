import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

enum LifeCycleState {
  S_00H(0, '芯片未进行密钥注入和信息初始化'),
  S_01H(1, '芯片出厂状态， 已配置记录仪编号'),
  S_02H(2, '记录仪生产（维修） 检验阶段'),
  S_03H(3, '记录仪生产（维修） 后出厂待装'),
  S_04H(4, '预安装状态， 可设置 VIN'),
  S_05H(5, '安装准备， 可设置 VIN、 车牌号'),
  S_06H(6, '安装自检'),
  S_08H(8, '正式运行状态'),
  S_0FH(0x0F, '报废/退服状态');

  const LifeCycleState(this.value, this.title);

  final int value;
  final String title;

  static LifeCycleState fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => LifeCycleState.S_00H,
    );
  }
}

// 记录仪生命周期状态查询应答
class RecorderLifeCycleGetRespModel extends BaseCommandFrameRespModel {
  RecorderLifeCycleGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  });

  static const int commandTypeRespTag = 0xF5;

  int get state {
    final dataBytesU8List = Uint8List.fromList(super.dataBytes);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }
}
