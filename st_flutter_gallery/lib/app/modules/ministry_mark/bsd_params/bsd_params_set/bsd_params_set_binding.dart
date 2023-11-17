import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/bsd_params/bsd_params_set/bsd_params_set_logic.dart';

class BsdParamsSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return BsdParamsSetLogic();
    });
  }
}
