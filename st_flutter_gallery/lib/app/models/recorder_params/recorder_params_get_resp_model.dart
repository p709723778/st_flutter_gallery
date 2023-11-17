import 'dart:typed_data';

import 'package:fast_gbk/fast_gbk.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/app/models/recorder_params/recorder_unique_number_model.dart';
import 'package:st/extension/string_extension.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';
import 'package:st/utils/list/list_util.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

class RecorderParamsGetRespModel extends BaseCommandFrameRespModel {
  RecorderParamsGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 121,
  });

  static const int commandTypeRespTag = 0xB1;

  String get fixedString {
    final data = respDataBytes.sublist(8, 8 + 8);
    final result = String.fromCharCodes(data);
    return result.replaceAll(regExp_Null, '');
  }

  Uint8List get executeVersionBytes {
    final data = respDataBytes.sublist(16, 16 + 1);
    final dataBytesU8List = Uint8List.fromList(data);
    return dataBytesU8List;
  }

  String get executeVersion {
    final result = BcdDataUtil.convertBCDToString(executeVersionBytes);
    return result;
  }

  Uint8List get executeOrderIdBytes {
    final data = respDataBytes.sublist(17, 17 + 1);
    final dataBytesU8List = Uint8List.fromList(data);
    return dataBytesU8List;
  }

  int get executeOrderId {
    final dataBytesByteData = executeOrderIdBytes.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);
    return result;
  }

  List<int> get recorderDatedBytes {
    final data = respDataBytes.sublist(18, 18 + 6);
    return data;
  }

  String get recorderDate {
    final result = BcdDataUtil.convertBCDToString(recorderDatedBytes);

    final year = result.substring(0, 2);
    final mouth = result.substring(2, 4);
    final day = result.substring(4, 6);
    final hour = result.substring(6, 8);
    final minute = result.substring(8, 10);
    final seconds = result.substring(10, 12);
    return '$year年$mouth月$day日$hour时$minute分$seconds秒';
  }

  RecorderUniqueNumberModel get recorderUniqueNumberModel {
    final data = respDataBytes.sublist(24, 24 + 35);

    return RecorderUniqueNumberModel(recorderUniqueNumberBytes: data);
  }

  String get carNumber {
    final data = respDataBytes.sublist(59, 59 + 14);
    final result = gbk.decode(data, allowMalformed: true);
    return result.replaceAll(regExp_Null, '');
  }

  String get carCategory {
    final data = respDataBytes.sublist(73, 73 + 16);
    final result = gbk.decode(data, allowMalformed: true);
    return result.replaceAll(regExp_Null, '');
  }

  String get vin {
    final data = respDataBytes.sublist(89, 89 + 17);
    final result = String.fromCharCodes(data);
    return result.replaceAll(regExp_Null, '');
  }

  List<int> get serialNumberBytes {
    final data = respDataBytes.sublist(106, 106 + 6);
    final dataBytesU8List = Uint8List.fromList(data);
    return dataBytesU8List;
  }

  String get serialNumber {
    final data = ListUtil.fixedLenList(serialNumberBytes, length: 6);
    final result = BcdDataUtil.convertBCDToString(data);
    final string = result.replaceAll(regExp_Null, '');
    return string.trimLeftStr('0');
  }

  Uint8List get impulseCoefficientBytes {
    final data = respDataBytes.sublist(112, 112 + 2);

    final dataLengthU16List = Uint8List.fromList(data);

    return dataLengthU16List;
  }

  int get impulseCoefficient {
    final dataBytesByteData = impulseCoefficientBytes.buffer.asByteData();
    final result = dataBytesByteData.getUint16(0);
    return result;
  }

  List<int> get firstInstallDateBytes {
    final data = respDataBytes.sublist(114, 114 + 6);
    return data;
  }

  String get firstInstallDate {
    final result = BcdDataUtil.convertBCDToString(firstInstallDateBytes);

    final year = result.substring(0, 2);
    final mouth = result.substring(2, 4);
    final day = result.substring(4, 6);
    final hour = result.substring(6, 8);
    final minute = result.substring(8, 10);
    final seconds = result.substring(10, 12);
    final dateTimeStr = '$year年$mouth月$day日$hour时$minute分$seconds秒';
    return dateTimeStr.replaceAll(regExp_Null, '');
  }
}
