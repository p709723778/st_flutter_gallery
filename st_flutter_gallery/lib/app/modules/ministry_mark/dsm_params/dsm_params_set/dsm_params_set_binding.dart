import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/dsm_params/dsm_params_set/dsm_params_set_logic.dart';

class DsmParamsSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DsmParamsSetLogic());
  }
}
