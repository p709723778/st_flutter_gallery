import 'package:get/get.dart';
import 'package:st/helpers/debug_settings/debug_settings_logic.dart';

class DebugSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DebugSettingsLogic.new);
  }
}
