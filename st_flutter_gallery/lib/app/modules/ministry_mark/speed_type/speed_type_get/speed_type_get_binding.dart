import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_get/speed_type_get_logic.dart';

class SpeedTypeGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return SpeedTypeGetLogic();
    });
  }
}
