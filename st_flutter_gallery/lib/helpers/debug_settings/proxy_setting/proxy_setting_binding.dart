import 'package:get/get.dart';
import 'package:st/helpers/debug_settings/proxy_setting/proxy_setting_logic.dart';

class ProxySettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ProxySettingLogic.new);
  }
}
