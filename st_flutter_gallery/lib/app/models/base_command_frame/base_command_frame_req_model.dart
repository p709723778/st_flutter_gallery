import 'dart:typed_data';

class BaseCommandFrameReqModel {
  BaseCommandFrameReqModel({
    this.startByte = 0x75,
    this.endByte = 0x78,
    this.commandType = 0x00,
    this.dataLength = 0x00,
    this.transportState = 0x00,
    this.transportSerialNumber = 0x00,
    this.dataBytes = const [],
    this.verifyFields = 0x00,
  }) {
    {
      dataLength = 8 + dataBytes.length + 1;

      final dataLengthByteData = ByteData(2)..setUint16(0, dataLength);

      final dataLengthU8List = dataLengthByteData.buffer.asUint8List();

      final transportSerialNumberByteData = ByteData(2)
        ..setUint16(0, transportSerialNumber);

      final transportSerialNumberU8List =
          transportSerialNumberByteData.buffer.asUint8List();

      final commandFrameData = [
        startByte,
        endByte,
        commandType,
        ...dataLengthU8List,
        transportState,
        ...transportSerialNumberU8List,
        ...dataBytes,
      ];

      var xorResult = 0;
      for (var i = 0; i < commandFrameData.length; i++) {
        xorResult ^= commandFrameData[i];
      }
      verifyFields = xorResult;
      commandFrameData.add(verifyFields);
      commandFrame = commandFrameData;
    }
  }

  // 起始字节,1个字节
  int startByte = 0x75;
  // 起始字节,1个字节
  int endByte = 0x78;
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

  /// 需要传输的字节命令帧
  List<int> commandFrame = [];

  /// 是否有效
  bool isValid() {
    return commandFrame.length == dataLength;
  }

  @override
  String toString() {
    super.toString();
    final data = {
      'startByte': startByte,
      'endByte': endByte,
      'commandType': commandType,
      'dataLength': dataLength,
      'transportState': transportState,
      'transportSerialNumber': transportSerialNumber,
      'dataBytes': dataBytes,
      'verifyFields': verifyFields,
    };

    return 'BaseCommandFrame: $data';
  }
}
