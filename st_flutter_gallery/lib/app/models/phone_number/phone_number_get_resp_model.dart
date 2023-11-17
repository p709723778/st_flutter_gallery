import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/extension/string_extension.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';

// 平台电话号码查询应答
class PhoneNumberGetRespModel extends BaseCommandFrameRespModel {
  PhoneNumberGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 19,
  });

  static const int commandTypeRespTag = 0xF1;

  /// 手机号码
  String get phoneNumber {
    final data = respDataBytes.sublist(8, 8 + dataLength);

    final result = BcdDataUtil.convertBCDToString(data); // 替换为你的BCD码数据类型
    logger.info("手机号码：$result");

    return result.trimLeftStr('0');
  }
}
