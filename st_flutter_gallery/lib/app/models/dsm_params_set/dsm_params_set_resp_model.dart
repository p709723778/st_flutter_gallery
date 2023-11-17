import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/utils/byte/bytes_data_util.dart';

/// DSM参数下发标定应答
class DsmParamsSetRespModel extends BaseCommandFrameRespModel {
  DsmParamsSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 16,
  });

  static const int commandTypeRespTag = 0xE3;

  /// 0：成功  1：失败
  int get result {
    final data = respDataBytes.sublist(8, 8 + 1);
    final result = BytesDataUtil.parseU8BytesToInt(bytes: data);
    return result;
  }

  /// 偏转角
  int get angleDeflection {
    final data = respDataBytes.sublist(9, 9 + 1);
    final result = BytesDataUtil.parseInt8BytesToInt(bytes: data);
    return result;
  }

  /// 俯仰角
  int get anglePitch {
    final data = respDataBytes.sublist(10, 10 + 1);
    final result = BytesDataUtil.parseInt8BytesToInt(bytes: data);
    return result;
  }

  /// 检测区域左上 X 坐标
  int get checkX {
    final data = respDataBytes.sublist(11, 11 + 2);
    final result = BytesDataUtil.parseU16BytesToInt(bytes: data);
    return result;
  }

  /// 检测区域左上 Y 坐标
  int get checkY {
    final data = respDataBytes.sublist(13, 13 + 2);
    final result = BytesDataUtil.parseU16BytesToInt(bytes: data);
    return result;
  }
}
