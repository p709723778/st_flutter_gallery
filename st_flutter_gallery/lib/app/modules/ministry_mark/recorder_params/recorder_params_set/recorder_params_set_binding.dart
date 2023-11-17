import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/recorder_params/recorder_params_set/recorder_params_set_logic.dart';

class RecorderParamsSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecorderParamsSetLogic());
  }
}
