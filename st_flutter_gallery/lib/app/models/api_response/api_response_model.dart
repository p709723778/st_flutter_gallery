import 'package:st/helpers/network/request_config.dart';

class ApiResponseModel {
  ApiResponseModel({
    this.success,
    this.errorCode,
    this.errorMessage,
    this.desc,
    this.requestId,
    this.data,
  });
  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errorCode = int.parse(json['errorCode'] ?? '');
    errorMessage = json['errorMessage'];
    desc = json['desc'];
    requestId = json['request_id'];
    data = json['data'];
  }

  bool? success;
  late int? errorCode;
  late String? errorMessage;
  late String? desc;
  late String? requestId;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['errorCode'] = errorCode;
    map['errorMessage'] = errorMessage;
    map['desc'] = desc;
    map['request_id'] = requestId;
    map['data'] = data;
    return map;
  }

  /// 当前请求状态是否成功
  bool get isSuccess => errorCode == RequestConfig.successCode;
}
