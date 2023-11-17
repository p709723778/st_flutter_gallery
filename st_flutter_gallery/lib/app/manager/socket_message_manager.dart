import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:let_log/let_log.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/bluetooth_socket_classic_manager.dart';
import 'package:st/app/manager/bluetooth_socket_classic_server_manager.dart';
import 'package:st/app/manager/bluetooth_socket_manager.dart';
import 'package:st/app/manager/tcp_socket_manager.dart';
import 'package:st/app/manager/web_socket_manager.dart';
import 'package:st/app/models/adas_params_set/adas_params_set_resp_model.dart';
import 'package:st/app/models/alarm_sound/alarm_sound_get_resp_model.dart';
import 'package:st/app/models/alarm_sound/alarm_sound_set_resp_model.dart';
import 'package:st/app/models/api_response/switch_on_model.dart';
import 'package:st/app/models/apn_4g/apn_4g_get_resp_model.dart';
import 'package:st/app/models/apn_4g/apn_4g_set_resp_model.dart';
import 'package:st/app/models/bsd_params_set/bsd_params_set_resp_model.dart';
import 'package:st/app/models/car_params/car_params_get_resp_model.dart';
import 'package:st/app/models/car_params/car_params_set_resp_model.dart';
import 'package:st/app/models/data_record_file/data_record_file_get_resp_model.dart';
import 'package:st/app/models/data_summary/data_summary_get_resp_model.dart';
import 'package:st/app/models/driver_ic/driver_ic_get_resp_model.dart';
import 'package:st/app/models/driver_ic/driver_ic_set_resp_model.dart';
import 'package:st/app/models/dsm_params_set/dsm_params_set_resp_model.dart';
import 'package:st/app/models/phone_number/phone_number_get_resp_model.dart';
import 'package:st/app/models/phone_number/phone_number_set_resp_model.dart';
import 'package:st/app/models/platform_domain_name/platform_domain_name_set_resp_model.dart';
import 'package:st/app/models/platform_ip/platform_ip_get_resp_model.dart';
import 'package:st/app/models/platform_ip/platform_ip_set_resp_model.dart';
import 'package:st/app/models/recorder_life_cycle/recorder_life_cycle_get_resp_model.dart';
import 'package:st/app/models/recorder_life_cycle/recorder_life_cycle_set_resp_model.dart';
import 'package:st/app/models/recorder_params/recorder_params_get_resp_model.dart';
import 'package:st/app/models/recorder_params/recorder_params_set_resp_model.dart';
import 'package:st/app/models/recorder_test/recorder_test_set_resp_model.dart';
import 'package:st/app/models/self_test_status/self_test_status_get_resp_model.dart';
import 'package:st/app/models/speed_type/speed_type_get_resp_model.dart';
import 'package:st/app/models/speed_type/speed_type_set_resp_model.dart';
import 'package:st/app/models/video_url/video_url_get_resp_model.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/loading/loading_util.dart';

enum LinkType {
  none(0, '未连接'), // 空
  ble(1, '蓝牙(低功率)'), //蓝牙
  ws(2, 'webSocket'), //webSocket
  classicClient(3, '蓝牙客户端模式'), //蓝牙经典 客户端模式
  classicServer(4, '蓝牙服务器模式'), //蓝牙经典 服务端模式
  tcp(5, 'WIFI'); //tcp

  const LinkType(this.value, this.title);

  final int value;
  final String title;

  static LinkType fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => LinkType.none,
    );
  }
}

class SocketMessageManager extends EventBus {
  SocketMessageManager._internal();

  /// 连接类型
  LinkType linkType = LinkType.none;

  static final SocketMessageManager instance = SocketMessageManager._internal();

  Future<void> disconnect() async {
    try {
      BluetoothSocketManager.instance.disconnect();

      WebSocketManager.instance.disconnect();

      await BluetoothSocketClassicManager.instance.disconnect();

      await BluetoothSocketClassicServerManager.instance.disconnect();

      await TcpSocketManager.instance.disconnect();

      logger.info('断开连接');
    } catch (e) {
      logger.info('断开连接异常$e');
    }
  }

  /// 发送消息
  void sendMessage(List<int> data, {bool isToast = true}) {
    try {
      if (!SwitchOnModel.isPass) {
        logger.info('程序逻辑出错');
        return;
      }
      if (linkType == LinkType.none) {
        showToast('请进行设备连接');
        return;
      }

      if (linkType == LinkType.ble) {
        logger.info('蓝牙发送消息 $data');
        BluetoothSocketManager.instance.sendMessage(data);
      } else if (linkType == LinkType.ws) {
        WebSocketManager.instance.sendMessage(data);
        logger.info('wifi发送消息 $data');
      } else if (linkType == LinkType.classicClient) {
        BluetoothSocketClassicManager.instance.sendMessage(data);
        logger.info('蓝牙经典发送消息 $data');
      } else if (linkType == LinkType.classicServer) {
        BluetoothSocketClassicServerManager.instance.sendMessage(data);
        logger.info('蓝牙经典服务器模式发送消息 $data');
      } else if (linkType == LinkType.tcp) {
        TcpSocketManager.instance.sendMessage(data);
        logger.info('tcp发送消息 $data');
      } else {
        logger.info('未连接任何方式通讯');
      }

      final hexString = data
          .map(
            (int byte) => byte.toRadixString(16).padLeft(2, '0'),
          )
          .join(' ')
          .toUpperCase();
      if (isToast) {
        EasyLoading.dismiss();
        LoadingUtil.showLoading();
      }

      final log = '\n [data]:$data\n [hex]:$hexString\n [数据长度]:${data.length}';
      Logger.net('[发送] done', type: 'ws', data: log);
    } catch (e) {
      logger.info('发送消息异常');
    }
  }

  void subscriptionMessage(dynamic rawData) {
    logger.fine("[ws收到]: $rawData");

    if (rawData is List<int>) {
      final hexString = rawData
          .map(
            (int byte) => byte.toRadixString(16).padLeft(2, '0'),
          )
          .join(' ')
          .toUpperCase();

      final log =
          '[rawData]:$rawData\n [hex]:$hexString\n [数据长度]:${rawData.length}';
      Logger.endNet('[收到] done', type: 'ws', data: log);
      final commandType = rawData[2];
      Object? model;
      if (commandType == AdasParamsSetRespModel.commandTypeRespTag) {
        model = AdasParamsSetRespModel(respDataBytes: rawData);
      } else if (commandType == AlarmSoundSetRespModel.commandTypeRespTag) {
        model = AlarmSoundSetRespModel(respDataBytes: rawData);
      } else if (commandType == AlarmSoundGetRespModel.commandTypeRespTag) {
        model = AlarmSoundGetRespModel(respDataBytes: rawData);
      } else if (commandType == BSDParamsSetRespModel.commandTypeRespTag) {
        model = BSDParamsSetRespModel(respDataBytes: rawData);
      } else if (commandType == CarParamsGetRespModel.commandTypeRespTag) {
        model = CarParamsGetRespModel(respDataBytes: rawData);
      } else if (commandType == CarParamsSetRespModel.commandTypeRespTag) {
        model = CarParamsSetRespModel(respDataBytes: rawData);
      } else if (commandType == DataSummaryGetRespModel.commandTypeRespTag) {
        model = DataSummaryGetRespModel(respDataBytes: rawData);
      } else if (commandType == DriverIcGetRespModel.commandTypeRespTag) {
        model = DriverIcGetRespModel(respDataBytes: rawData);
      } else if (commandType == DriverIcSetRespModel.commandTypeRespTag) {
        model = DriverIcSetRespModel(respDataBytes: rawData);
      } else if (commandType == DsmParamsSetRespModel.commandTypeRespTag) {
        model = DsmParamsSetRespModel(respDataBytes: rawData);
      } else if (commandType == PhoneNumberGetRespModel.commandTypeRespTag) {
        model = PhoneNumberGetRespModel(respDataBytes: rawData);
      } else if (commandType == PhoneNumberSetRespModel.commandTypeRespTag) {
        model = PhoneNumberSetRespModel(respDataBytes: rawData);
      } else if (commandType ==
          PlatformDomainNameSetRespModel.commandTypeRespTag) {
        model = PlatformDomainNameSetRespModel(respDataBytes: rawData);
      } else if (commandType == PlatformIpGetRespModel.commandTypeRespTag) {
        model = PlatformIpGetRespModel(respDataBytes: rawData);
      } else if (commandType == PlatformIpSetRespModel.commandTypeRespTag) {
        model = PlatformIpSetRespModel(respDataBytes: rawData);
      } else if (commandType ==
          RecorderLifeCycleGetRespModel.commandTypeRespTag) {
        model = RecorderLifeCycleGetRespModel(respDataBytes: rawData);
      } else if (commandType ==
          RecorderLifeCycleSetRespModel.commandTypeRespTag) {
        model = RecorderLifeCycleSetRespModel(respDataBytes: rawData);
      } else if (commandType == RecorderTestSetRespModel.commandTypeRespTag) {
        model = RecorderTestSetRespModel(respDataBytes: rawData);
      } else if (commandType == SelfTestStatusGetRespModel.commandTypeRespTag) {
        model = SelfTestStatusGetRespModel(respDataBytes: rawData);
      } else if (commandType == SpeedTypeGetRespModel.commandTypeRespTag) {
        model = SpeedTypeGetRespModel(respDataBytes: rawData);
      } else if (commandType == SpeedTypeSetRespModel.commandTypeRespTag) {
        model = SpeedTypeSetRespModel(respDataBytes: rawData);
      } else if (commandType == VideoUrlGetRespModel.commandTypeRespTag) {
        model = VideoUrlGetRespModel(respDataBytes: rawData);
      } else if (commandType == RecorderParamsGetRespModel.commandTypeRespTag) {
        model = RecorderParamsGetRespModel(respDataBytes: rawData);
      } else if (commandType == RecorderParamsSetRespModel.commandTypeRespTag) {
        model = RecorderParamsSetRespModel(respDataBytes: rawData);
      } else if (commandType == Apn4gGetRespModel.commandTypeRespTag) {
        model = Apn4gGetRespModel(respDataBytes: rawData);
      } else if (commandType == Apn4gSetRespModel.commandTypeRespTag) {
        model = Apn4gSetRespModel(respDataBytes: rawData);
      } else if (commandType == DataRecordFileGetRespModel.commandTypeRespTag) {
        model = DataRecordFileGetRespModel(respDataBytes: rawData);
      }

      if (model != null) {
        fire(model);
      }
    }
  }
}
