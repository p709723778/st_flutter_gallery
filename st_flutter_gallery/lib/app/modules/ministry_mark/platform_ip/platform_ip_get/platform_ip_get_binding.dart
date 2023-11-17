import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_get/platform_ip_get_logic.dart';

class PlatformIpGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return PlatformIpGetLogic();
    });
  }
}
