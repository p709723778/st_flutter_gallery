import 'dart:io';
import 'dart:typed_data';

import 'package:st/app/constants/number_key.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/app/models/data_record_file/data_record_file_get_req_model.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/byte/bytes_data_util.dart';

class DataRecordFileGetRespModel extends BaseCommandFrameRespModel {
  DataRecordFileGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = int64MaxValue,
  }) {
    var data = respDataBytes.sublist(8, 8 + 1);

    final type = BytesDataUtil.parseU8BytesToInt(bytes: data);
    recordFileType = RecordFileType.fromString(type);

    // 数据流索引
    var index = 9;
    // 文件字节长度
    var length = 0;
    // 文件数
    var fileNum = 0;

    while ((dataLengthResp - 8 - 1 - 1) >= index) {
      fileNum += 1;
      data = respDataBytes.sublist(index, index + 1);
      final byteDate = Uint32List.fromList(data).buffer.asByteData();
      length = byteDate.getUint32(0);
      index += 1;
      data = respDataBytes.sublist(index, index + length);
      index += length;

      // 创建一个临时文件
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/temp.txt')
        // 将字节写入文件
        ..writeAsBytesSync(data);

      files.add(tempFile);

      // 打印文件路径
      logger.info('第$fileNum个文件,路径：${tempFile.path}');
    }
  }

  static const int commandTypeRespTag = 0xB3;

  RecordFileType? recordFileType;

  List<File> files = [];
}
