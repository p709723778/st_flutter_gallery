import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

// 视频url地址查询应答
class VideoUrlGetRespModel extends BaseCommandFrameRespModel {
  VideoUrlGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
  });

  static const int commandTypeRespTag = 0xF6;

  /// U_8  type (与请求对应)
  int get type {
    final data = respDataBytes.sublist(8, 8 + 1);
    final result = data[0];
    return result;
  }

  /// url长度
  int get urlLen {
    final data = respDataBytes.sublist(9, 9 + 1);
    final result = data[0];
    return result;
  }

  /// tcp地址
  String get url {
    final data = respDataBytes.sublist(10, dataLengthResp - 1);
    final result = String.fromCharCodes(data);

    logger.info('视频url $result');

    return result.replaceAll(regExp_Null, '');
  }
}
