import 'package:st/app/models/base_command_frame/base_command_frame_resp_model.dart';
import 'package:st/app/models/driver_ic/driver_ic_data_model.dart';

class DriverIcGetRespModel extends BaseCommandFrameRespModel {
  DriverIcGetRespModel({
    required super.respDataBytes,
    super.commandType = commandTypeRespTag,
    super.dataLength = 137,
  }) {
    driverIcDataModel = DriverIcDataModel(dataBytes: dataBytes);
  }

  static const int commandTypeRespTag = 0xF7;

  DriverIcDataModel? driverIcDataModel;
}
