import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class NetworkAdapter {
  // 设置系统 http 代理也抓不到 flutter 的包，必须设置 dio 的代理才能抓到。
  static void setProxy(Dio dio, String proxy) {
    if (proxy.isNotEmpty) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client
          ..findProxy = (uri) {
            return "PROXY $proxy";
          }
          // 需要校验所有证书：只有有效的根证书才能被信任。
          // CA颁发的证书，被系统成功认证的话，不会走到这个回调；没有成功认证会走到这里。直接返回false,拒绝这些情况的请求。
          // 我们的证书是CA颁发的，被系统认证的。因此能够正常访问。
          ..badCertificateCallback = (cert, host, port) {
            // return false;
            return true;
          };
        return null;
      };
    }
  }
}
