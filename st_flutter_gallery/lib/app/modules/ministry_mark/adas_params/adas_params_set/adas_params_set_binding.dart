import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/adas_params/adas_params_set/adas_params_set_logic.dart';

class AdasParamsSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return AdasParamsSetLogic();
    });
  }
}
