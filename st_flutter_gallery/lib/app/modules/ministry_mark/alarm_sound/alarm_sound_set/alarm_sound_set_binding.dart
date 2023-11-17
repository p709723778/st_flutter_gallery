import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/alarm_sound/alarm_sound_set/alarm_sound_set_logic.dart';

class AlarmSoundSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return AlarmSoundSetLogic();
    });
  }
}
