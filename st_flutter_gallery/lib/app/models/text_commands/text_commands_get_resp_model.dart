import 'package:fast_gbk/fast_gbk.dart';
import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

class TextCommandsGetRespModel extends BaseCommandFrameRespModel {
  TextCommandsGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 0,
  });

  static const int commandTypeRespTag = 0xFB;

  String get textCommands {
    final result = gbk.decode(dataBytes).replaceAll(regExp_Null, '');
    return result;
  }
}
