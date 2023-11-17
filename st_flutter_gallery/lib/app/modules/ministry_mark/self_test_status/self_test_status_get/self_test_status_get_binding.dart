import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/self_test_status/self_test_status_get/self_test_status_get_logic.dart';

class SelfTestStatusGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return SelfTestStatusGetLogic();
    });
  }
}
