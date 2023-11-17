import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/recorder_life_cycle/recorder_life_cycle_set/recorder_life_cycle_set_logic.dart';

class RecorderLifeCycleSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return RecorderLifeCycleSetLogic();
    });
  }
}
