import 'package:get/get.dart';
import 'package:st/services/sp_service/sp_service.dart';

class ServicesManager {
  static Future<void> initServices() async {
    await Get.putAsync(() => SpService().init());
  }
}
