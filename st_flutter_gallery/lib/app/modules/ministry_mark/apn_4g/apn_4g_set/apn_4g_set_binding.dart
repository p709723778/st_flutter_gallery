import 'package:get/get.dart';

import 'apn_4g_set_logic.dart';

class Apn4gSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Apn4gSetLogic());
  }
}
