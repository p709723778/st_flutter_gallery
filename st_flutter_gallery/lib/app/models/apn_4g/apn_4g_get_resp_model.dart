import 'dart:typed_data';

import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

class Apn4gGetRespModel extends BaseCommandFrameRespModel {
  Apn4gGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
  });

  static const int commandTypeRespTag = 0xFA;

  int get apnDomainLen {
    final data = respDataBytes.sublist(8, 8 + 1);
    final dataBytesU8List = Uint8List.fromList(data);
    final dataBytesByteData = dataBytesU8List.buffer.asByteData();
    final result = dataBytesByteData.getUint8(0);

    return result;
  }

  String get apnDomain {
    final data = respDataBytes.sublist(9, dataLengthResp - 1);

    final result = String.fromCharCodes(data);

    return result.replaceAll(regExp_Null, '');
  }
}
