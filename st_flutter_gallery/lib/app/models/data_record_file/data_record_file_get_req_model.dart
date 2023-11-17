import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

enum RecordFileType {
  driveStatus(0x21, '行驶状态记录'),
  accidentSuspicion(0x22, '事故疑点记录'),
  timeOutDriveStatus(0x23, '超时驾驶记录'),
  driverStatus(0x24, '驾驶人记录'),
  logStatus(0x25, '日志记录');

  const RecordFileType(this.value, this.title);

  final int value;

  final String title;

  static RecordFileType fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => RecordFileType.logStatus,
    );
  }
}

class DataRecordFileGetReqModel extends BaseCommandFrameReqModel {
  DataRecordFileGetReqModel({
    super.dataBytes,
    super.commandType = commandTypeWifiOrBLE,
    super.dataLength = 0,
  });

  // 蓝牙或者WIFI通过命令=0x33协议采集，回应0xB3 (注意每个文件查询时间不大于1个小时，
  // 超过将不会回应，最多每条协议请求的文件个数不大于50个);
  static const int commandTypeWifiOrBLE = 0x33;
  // 蓝牙FTP协议采集，命令=0x34（仅蓝牙支持）,协议无回应，
  // 终端收到0x34命令后通过FTP发送文件，
  // 手机端需先打开蓝牙FTP服务，另外，每次采集的单个文件时长不能大于1个小时。
  static const int commandTypeFTP_BLE = 0x34;
}
