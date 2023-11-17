import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class SwitchOnModel {
  SwitchOnModel({
    this.switchOn = 0,
    this.message = '',
  });

  factory SwitchOnModel.fromJson(Map<String, dynamic>? json) => SwitchOnModel(
        switchOn: json?["sg_switch"] ?? 0,
        message: json?["message"] ?? '',
      );

  int? switchOn;
  String? message;

  Map<String, dynamic> toJson() => {
        "sg_switch": switchOn ?? 0,
        "message": message ?? '',
      };

  /// 是否通过
  static bool get isPass {
    final now = DateTime.now();

    final inputFormat = DateFormat('yy-MM-dd HH:mm:ss');
    final dateTime = inputFormat.parse('2024-6-25 23:59:59');

    if (now.isAfter(dateTime)) {
      return false;
    }

    if (_switchOnModel.switchOn != 1) {
      return true;
    }
    return false;
  }

  static bool _isSuccess = false;

  static SwitchOnModel _switchOnModel = SwitchOnModel();

  static Future<SwitchOnModel> requestSwitchOn() async {
    if (_isSuccess) return _switchOnModel;
    try {
      final response = await Dio().request(
        Apis.project_settings,
      );

      _switchOnModel = SwitchOnModel.fromJson(response.data);
      _isSuccess = true;
      return _switchOnModel;
    } on Exception catch (e) {
      logger.info(e);
      return _switchOnModel;
    }
  }
}
