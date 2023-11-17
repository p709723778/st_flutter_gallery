import 'package:st/app/models/base_command_frame/base_command_frame_req_model.dart';

enum VideoUrlType {
  td0(0, '通道0'), //通道 0
  td1(1, '通道1'),
  td2(2, '通道2'),
  td3(3, '通道3'),
  td4(4, '通道4'),
  td5(5, '通道5'),
  td6(6, '通道6'),
  td7(7, '通道7'),
  adas(8, 'adas通道'),
  dsm(9, 'dsm通道'),
  bsd(10, 'bsd通道');

  const VideoUrlType(this.value, this.title);

  final int value;

  final String title;

  static VideoUrlType fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => VideoUrlType.td0,
    );
  }
}

// 视频url地址查询（仅WIFI支持）
class VideoUrlGetReqModel extends BaseCommandFrameReqModel {
  VideoUrlGetReqModel({
    required super.dataBytes,
    super.commandType = 0x76,
    super.dataLength = 10,
  });

  static void test() {
    // 一字节通道类型：
    // 0--7 ：通道号
    // 8：adas通道
    // 9：dsm:通道
    // 10:bsd通道
    // 查询对应通道的视频拉流地址  （大部分情况通道0是adas通道，1是dsm,2是bsd; 不确定的话就用8\9\10查询，将返回对应视频地址）
    final model = VideoUrlGetReqModel(
      dataBytes: [0],
    );
    model.commandFrame;
  }
}
