import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

enum AlgorithmMarkType {
  td0(0, '通道0全屏'), //通道 0
  td1(1, '通道1全屏'),
  td2(2, '通道2全屏'),
  td3(3, '通道3全屏'),
  td4(4, '通道4全屏'),
  td5(5, '通道5全屏'),
  td6(6, '通道6全屏'),
  td7(7, '通道7全屏'),
  squares4(8, '四宫格显示'), // 四宫格
  squares9(9, '九宫格显示'), // 九宫格
  openBSD(10, '打开BSD辅助线'), // 打开BSD辅助线
  openADAS(11, '打开ADAS辅助线'), // 打开ADAS辅助线
  clearLine(12, '清除辅助线'); // 清除辅助线

  const AlgorithmMarkType(this.value, this.title);

  final int value;
  final String title;

  static AlgorithmMarkType fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => AlgorithmMarkType.td0,
    );
  }
}

// final model = AlgorithmMarkReqModel(dataBytes: [1]);

// 算法标定设置(打开/关闭标定辅助线)
class AlgorithmMarkSetReqModel extends BaseCommandFrameReqModel {
  AlgorithmMarkSetReqModel({
    super.commandType = 0x60,
    super.dataLength = 10,
    required super.dataBytes,
  });

  /// 算法标定发送命令
  static void sendCommand(AlgorithmMarkType type) {
    SocketMessageManager.instance.sendMessage(
      AlgorithmMarkSetReqModel(dataBytes: [type.value]).commandFrame,
    );
  }
}
