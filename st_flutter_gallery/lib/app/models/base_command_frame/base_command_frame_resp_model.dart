import 'package:flutter/foundation.dart';

class BaseCommandFrameRespModel {
  BaseCommandFrameRespModel({
    required this.respDataBytes,
    this.commandType = 0x00,
    this.dataLength = 0x00,
  }) {
    startByteResp = respDataBytes[0];
    endByteResp = respDataBytes[1];
    commandTypeResp = respDataBytes[2];

    final dataLengthU8List =
        Uint8List.fromList(respDataBytes.sublist(3, 3 + 2));
    final dataLengthU16List = dataLengthU8List.buffer.asUint16List();
    final dataLengthByteData = dataLengthU16List.buffer.asByteData();
    dataLengthResp = dataLengthByteData.getUint16(0);

    transportState = respDataBytes[5];

    final transportSerialNumberU8List =
        Uint8List.fromList(respDataBytes.sublist(6, 6 + 2));
    final transportSerialNumberU16List =
        transportSerialNumberU8List.buffer.asUint16List();
    final transportSerialNumberByteData =
        transportSerialNumberU16List.buffer.asByteData();
    transportSerialNumber = transportSerialNumberByteData.getUint16(0);

    dataBytes = respDataBytes.sublist(8, respDataBytes.length - 1);
    verifyFields = respDataBytes.last;
    dataLength = dataBytes.length;
  }

  // 返回的数据
  List<int> respDataBytes = [];

  // 起始字节,1个字节
  final int _startByte = 0x57;
  // 起始字节,1个字节
  final int _endByte = 0x78;
  // 命令字(MCmd),1个字节
  int commandType = 0x00;
  // 数据帧长度(所有字节总长度),2个字节
  int dataLength = 0x00;
  // 传输状态字(暂时不解析),1个字节
  int transportState = 0x00;
  // 传输序列号(暂时不解析),2个字节
  int transportSerialNumber = 0x00;
  // 数据帧内容,n个字节
  List<int> dataBytes = [];
  // 校验字 (所有字节异或值),1个字节
  int verifyFields = 0x00;

  // 起始字节,1个字节
  int startByteResp = 0x00;
  // 起始字节,1个字节
  int endByteResp = 0x00;
  // 命令字(MCmd),1个字节
  int commandTypeResp = 0x00;
  // 数据帧长度(所有字节总长度),2个字节
  int dataLengthResp = 0x00;

  /// 是否有效
  bool isValid() {
    return startByteResp == _startByte &&
        endByteResp == _endByte &&
        commandTypeResp == commandType;
  }

  @override
  String toString() {
    super.toString();
    final data = {
      'startByte': startByteResp,
      'endByte': endByteResp,
      'commandType': commandTypeResp,
      'dataLength': dataLengthResp,
      'transportState': transportState,
      'transportSerialNumber': transportSerialNumber,
      'dataBytes': dataBytes,
      'verifyFields': verifyFields,
    };

    return 'BaseCommandFrameRespModel: $data';
  }
}
