import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/basic_parameter/basic_parameter_get/basic_parameter_get_logic.dart';

class BasicParameterGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BasicParameterGetLogic());
  }
}
