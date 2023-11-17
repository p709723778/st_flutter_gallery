import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/driver_ic/driver_ic_set/driver_ic_set_logic.dart';

class DriverIcSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return DriverIcSetLogic();
    });
  }
}
