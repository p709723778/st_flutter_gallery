import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/platform_domain_name/platform_domain_name_get/platform_domain_name_get_logic.dart';

class PlatformDomainNameGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return PlatformDomainNameGetLogic();
    });
  }
}
