import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

// 平台IP端口查询应答
class PlatformIpGetRespModel extends BaseCommandFrameRespModel {
  PlatformIpGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
  });

  static const int commandTypeRespTag = 0xF0;

  /// tcp地址
  String get tcpInfo {
    final data = dataBytes;
    final result = String.fromCharCodes(data);

    return result;
  }
}
