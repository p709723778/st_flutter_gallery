import 'package:get/get.dart';
import 'package:st/app/network_request/cookie_jar_manager/cookie_jar_manager.dart';
import 'package:st/services/sp_service/sp_service.dart';

class ServicesManager {
  static Future<void> initServices() async {
    await Get.putAsync(() => SpService().init());
    await CookieJarManager().init();
  }
}
