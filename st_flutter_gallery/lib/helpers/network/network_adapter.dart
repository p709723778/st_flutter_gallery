import 'dart:io';

import 'package:dio/io.dart';
import 'package:st/helpers/network/network_helper.dart';

extension NetworkAdapter on NetworkHelper {
  // 设置系统 http 代理也抓不到 flutter 的包，必须设置 dio 的代理才能抓到。
  void setProxy(String proxy) {
    if (proxy.isNotEmpty) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          return HttpClient(context: SecurityContext())
            ..findProxy = (uri) {
              return "PROXY $proxy";
            }
            ..badCertificateCallback = (cert, host, port) => true;
        },
      );
    }
  }
}
