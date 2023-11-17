import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/driver_ic/driver_ic_get/driver_ic_get_logic.dart';

class DriverIcGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return DriverIcGetLogic();
    });
  }
}
