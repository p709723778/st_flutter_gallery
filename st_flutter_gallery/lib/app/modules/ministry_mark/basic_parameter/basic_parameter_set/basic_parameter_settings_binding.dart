import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/basic_parameter/basic_parameter_set/basic_parameter_settings_logic.dart';

class BasicParameterSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return BasicParameterSettingsLogic();
    });
  }
}
