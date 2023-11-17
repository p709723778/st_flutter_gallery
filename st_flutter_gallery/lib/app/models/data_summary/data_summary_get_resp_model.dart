import 'package:st/app/constants/number_key.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/app/models/recorder_params/recorder_unique_number_model.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';

// D.13 数据摘要测试应答帧定义
class DataSummaryGetRespModel extends BaseCommandFrameRespModel {
  DataSummaryGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = int64MaxValue,
  });

  static const int commandTypeRespTag = 0xD8;

  /// 记录仪时间
  String get time {
    final data = respDataBytes.sublist(8, 8 + 6);
    final recorderTime = BcdDataUtil.convertBCDToString(data);
    final year = recorderTime.substring(0, 2);
    final mouth = recorderTime.substring(2, 4);
    final day = recorderTime.substring(4, 6);
    final hour = recorderTime.substring(6, 8);
    final minute = recorderTime.substring(8, 10);
    final seconds = recorderTime.substring(10, 12);
    return '$year年$mouth月$day日$hour时$minute分$seconds秒';
  }

  /// 记录仪唯一性编号
  RecorderUniqueNumberModel get recorderUniqueNumber {
    final data = respDataBytes.sublist(14, 14 + 35);
    return RecorderUniqueNumberModel(recorderUniqueNumberBytes: data);
  }

  /// 数据摘要
  String get dataSummary {
    final data = respDataBytes.sublist(49, 49 + 32);
    final saltHexString = data
        .map(
          (int byte) => byte.toRadixString(16).padLeft(2, '0'),
        )
        .join(' ');

    // return String.fromCharCodes(data);
    return saltHexString;
  }
}
