import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_set/platform_ip_set_logic.dart';

class PlatformIpSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return PlatformIpSetLogic();
    });
  }
}
