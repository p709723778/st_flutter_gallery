import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/wifi/wifi_logic.dart';

class WifiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return WifiLogic();
    });
  }
}
