import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/recorder_life_cycle/recorder_life_cycle_get/recorder_life_cycle_get_logic.dart';

class RecorderLifeCycleGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return RecorderLifeCycleGetLogic();
    });
  }
}
