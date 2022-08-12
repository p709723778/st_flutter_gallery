import 'package:st/helpers/network/request_config.dart';

class ApiResponseModel {
  ApiResponseModel({
    this.status,
    this.code,
    this.message,
    this.desc,
    this.requestId,
    this.data,
  });
  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    desc = json['desc'];
    requestId = json['request_id'];
    data = json['data'];
  }

  bool? status;
  late int? code;
  late String? message;
  late String? desc;
  late String? requestId;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    map['desc'] = desc;
    map['request_id'] = requestId;
    map['data'] = data;
    return map;
  }

  /// 当前请求状态是否成功
  bool get isSuccess => code == RequestConfig.successCode;
}
