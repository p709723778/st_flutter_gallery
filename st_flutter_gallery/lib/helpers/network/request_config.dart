import 'package:st/config/env_config.dart';

class RequestConfig {
  /// 主域名地址
  static String baseUrl = EnvConfig.baseUrl;

  /// 请求连接超时时长
  static const connectTimeout = Duration(seconds: 15);

  /// 请求发送超时时长
  static const sendTimeout = Duration(seconds: 15);

  /// 请求接收超时时长
  static const receiveTimeout = Duration(seconds: 15);

  /// 服务器请求成功 code 码
  static const successCode = 200;
}
