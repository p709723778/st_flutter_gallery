import 'package:fast_gbk/fast_gbk.dart';
import 'package:flutter/foundation.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';

import '../../../utils/reg_exps/reg_exps.dart';

// 车辆参数信息查询应答
class CarParamsGetRespModel extends BaseCommandFrameRespModel {
  CarParamsGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 125,
  }) {
    var data = respDataBytes.sublist(8, 8 + 2);
    // 省域ID
    provinceId = Uint8List.fromList(data).buffer.asByteData().getUint16(0);

    data = respDataBytes.sublist(10, 10 + 2);
    // 市域ID
    cityId = Uint8List.fromList(data).buffer.asByteData().getUint16(0);

    data = respDataBytes.sublist(12, 12 + 11);
    // 制造商ID
    manufacturerId =
        gbk.decode(data, allowMalformed: true).replaceAll(regExp_Null, '');

    data = respDataBytes.sublist(23, 23 + 30);
    // 终端型号
    terminalMode =
        gbk.decode(data, allowMalformed: true).replaceAll(regExp_Null, '');

    data = respDataBytes.sublist(53, 53 + 30);
    // 终端ID
    terminalId =
        gbk.decode(data, allowMalformed: true).replaceAll(regExp_Null, '');

    data = respDataBytes.sublist(83, 83 + 1);
    // 车牌颜色
    carNumberColor = Uint8List.fromList(data).buffer.asByteData().getUint8(0);

    data = respDataBytes.sublist(84, 84 + 40);
    // 车牌号
    carNumber =
        gbk.decode(data, allowMalformed: true).replaceAll(regExp_Null, '');
  }

  // final manufacturerId = controllerManufacturerId.text;
  // final terminalMode = controllerTerminalMode.text;
  // final terminalId = controllerTerminalId.text;
  // final carNumber = controllerCarNumber.text;
  //
  static const int commandTypeRespTag = 0xF2;

  /// 省
  int provinceId = 0;

  /// 市
  int cityId = 0;

  /// 制造商id
  String manufacturerId = '';

  ///  终端型号
  String terminalMode = '';

  /// 终端ID
  String terminalId = '';

  /// 车牌颜色
  int carNumberColor = 0;

  /// 车牌号
  String carNumber = '';
}
