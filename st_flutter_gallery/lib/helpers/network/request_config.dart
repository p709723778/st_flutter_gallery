import 'package:st/config/env_config.dart';

class RequestConfig {
  /// 主域名地址
  static String baseUrl = EnvConfig.host;

  /// 请求连接超时时长
  static const connectTimeout = 15000;

  /// 请求发送超时时长
  static const sendTimeout = 15000;

  /// 请求接收超时时长
  static const receiveTimeout = 15000;

  /// 服务器请求成功 code 码
  static const successCode = 200;
}
