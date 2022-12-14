import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/helpers/network/request_config.dart';

class CookieJarManager extends GetxService {
  static String? _cookiePath;

  static bool isHaveCookie = false;
  static Future<String> get cookiePath async {
    if (_cookiePath == null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      _cookiePath = appDocDir.path;
    }
    return _cookiePath!;
  }

  static PersistCookieJar? cookieJar;
  static Future<PersistCookieJar> get _cookieJar async {
    if (cookieJar == null) {
      final path = await cookiePath;
      cookieJar = PersistCookieJar(storage: FileStorage(path));
      //Get cookies
      final results = await cookieJar?.loadForRequest(
            Uri.parse('${RequestConfig.baseUrl}${Apis.login}'),
          ) ??
          [];
      isHaveCookie = results.isNotEmpty;
    }
    return cookieJar!;
  }

  /// 删除cookie
  static void deleteCookie() {
    cookieJar?.delete(Uri.parse('${RequestConfig.baseUrl}${Apis.login}'));
  }

  Future<CookieJarManager> init() async {
    cookieJar = await _cookieJar;
    return this;
  }
}
