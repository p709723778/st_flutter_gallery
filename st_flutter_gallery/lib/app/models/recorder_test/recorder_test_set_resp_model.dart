import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';

/// D.11 定位性能测试应答帧定义
class RecorderTestSetRespModel extends BaseCommandFrameRespModel {
  RecorderTestSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 10,
  });

  static const int commandTypeRespTag = 0xD6;

  String get time {
    final bcdData = respDataBytes.sublist(8, 8 + 6);

    final result = BcdDataUtil.convertBCDToString(bcdData);

    final year = result.substring(0, 2);
    final mouth = result.substring(2, 4);
    final day = result.substring(4, 6);
    final hour = result.substring(6, 8);
    final minute = result.substring(8, 10);
    final seconds = result.substring(10, 12);
    return '$year年$mouth月$day日$hour时$minute分$seconds秒';
  }

  int get ggaDataLength {
    final dataLengthU8List =
        Uint8List.fromList(respDataBytes.sublist(14, 14 + 2));
    final dataLengthU16List = dataLengthU8List.buffer.asUint16List();
    final dataLengthByteData = dataLengthU16List.buffer.asByteData();
    return dataLengthByteData.getUint16(0);
  }

  int get rmcDataLength {
    final dataLengthU8List =
        Uint8List.fromList(respDataBytes.sublist(16, 16 + 2));
    final dataLengthU16List = dataLengthU8List.buffer.asUint16List();
    final dataLengthByteData = dataLengthU16List.buffer.asByteData();
    return dataLengthByteData.getUint16(0);
  }

  String get ggaData {
    final data = respDataBytes.sublist(18, 18 + ggaDataLength);

    return String.fromCharCodes(data);
  }

  String get rmcData {
    final data = respDataBytes.sublist(
      18 + ggaDataLength,
      (18 + ggaDataLength) + rmcDataLength,
    );

    return String.fromCharCodes(data);
  }
}
