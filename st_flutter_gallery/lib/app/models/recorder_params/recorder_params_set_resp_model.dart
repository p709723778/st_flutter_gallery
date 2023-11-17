import 'dart:convert';
import 'dart:typed_data';

import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/app/models/recorder_params/recorder_unique_number_model.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';

class RecorderParamsSetRespModel extends BaseCommandFrameRespModel {
  RecorderParamsSetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 106,
  });

  static const int commandTypeRespTag = 0xC1;

  /// 参数设置标识
  int get paramSetFlag {
    final data = respDataBytes.sublist(8, 8 + 1);
    final dataBytesU8List = Uint8List.fromList(data);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }

  RecorderUniqueNumberModel get recorderUniqueNumberModel {
    final data = respDataBytes.sublist(9, 9 + 35);

    return RecorderUniqueNumberModel(recorderUniqueNumberBytes: data);
  }

  String get carNumber {
    final data = respDataBytes.sublist(44, 44 + 14);
    final result = utf8.decode(data);
    return result;
  }

  String get carCategory {
    final data = respDataBytes.sublist(58, 58 + 16);
    final result = utf8.decode(data);
    return result;
  }

  String get vin {
    final data = respDataBytes.sublist(74, 74 + 17);
    final result = String.fromCharCodes(data);
    return result;
  }

  List<int> get serialNumberBytes {
    final data = respDataBytes.sublist(91, 91 + 6);
    return data;
  }

  String get serialNumber {
    final result = BcdDataUtil.convertBCDToString(serialNumberBytes);
    return result;
  }

  Uint8List get impulseCoefficientBytes {
    final data = respDataBytes.sublist(97, 97 + 2);
    final dataBytesU8List = Uint8List.fromList(data);
    return dataBytesU8List;
  }

  int get impulseCoefficient {
    final dataBytesByteData = impulseCoefficientBytes.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }

  List<int> get firstInstallDateBytes {
    final data = respDataBytes.sublist(99, 99 + 6);
    return data;
  }

  String get firstInstallDate {
    final result = BcdDataUtil.convertBCDToString(firstInstallDateBytes);
    return result;
  }
}
