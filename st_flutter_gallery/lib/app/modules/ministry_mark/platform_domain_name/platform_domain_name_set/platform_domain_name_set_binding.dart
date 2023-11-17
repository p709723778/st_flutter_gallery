import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/platform_domain_name/platform_domain_name_set/platform_domain_name_set_logic.dart';

class PlatformDomainNameSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return PlatformDomainNameSetLogic();
    });
  }
}
