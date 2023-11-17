import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

// D.10 定位性能测试命令帧定义
class RecorderTestSetReqModel extends BaseCommandFrameReqModel {
  RecorderTestSetReqModel({
    required super.dataBytes,
    super.commandType = commandTypeStart,
    super.dataLength = 11,
  });

  // 开始和结束 命令字(MCmd),1个字节
  static const int commandTypeStart = 0x56;
  static const int commandTypeEnd = 0x57;

  static void test() {
    const number = 4;
    final dataLengthByteData = ByteData(2)..setUint16(0, number);

    final dataLengthU8List = dataLengthByteData.buffer.asUint8List();

    final model = RecorderTestSetReqModel(
      dataBytes: dataLengthU8List,
      commandType: RecorderTestSetReqModel.commandTypeStart,
    );
    final model2 = RecorderTestSetReqModel(
      dataBytes: dataLengthU8List,
      commandType: RecorderTestSetReqModel.commandTypeEnd,
    );
  }
}
