import 'package:get/get.dart';
import 'package:st/helpers/debug_settings/env_setting/env_setting_logic.dart';

class EnvSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EnvSettingLogic.new);
  }
}
