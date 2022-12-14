import 'package:dio/dio.dart';

class ApiResponseModel {
  ApiResponseModel({
    this.timestamp,
    this.status,
    this.message,
    this.stackMessage,
    this.path,
    this.extraInfo,
    this.success,
    this.data,
    this.response,
  });
  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    message = json['message'];
    stackMessage = json['stackmessage'];
    path = json['path'];
    extraInfo = json['extraInfo'];
    success = json['success'];
    data = json['data'];
  }

  int? timestamp;
  int? status;
  late String? message;
  late String? stackMessage;
  late String? path;
  late Map? extraInfo;
  bool? success;
  dynamic data;
  dynamic dataModel;
  Response? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = timestamp;
    map['status'] = status;
    map['message'] = message;
    map['stackmessage'] = stackMessage;
    map['path'] = path;
    map['extraInfo'] = extraInfo;
    map['success'] = success;
    map['data'] = data;
    return map;
  }

  /// 当前请求状态是否成功
  bool? get isSuccess => success;
}
