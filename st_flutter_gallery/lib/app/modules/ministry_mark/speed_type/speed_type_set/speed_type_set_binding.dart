import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_set/speed_type_set_logic.dart';

class SpeedTypeSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return SpeedTypeSetLogic();
    });
  }
}
