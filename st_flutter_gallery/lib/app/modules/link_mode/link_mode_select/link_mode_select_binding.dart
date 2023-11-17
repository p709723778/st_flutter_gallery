import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_logic.dart';

class LinkModeSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LinkModeSelectLogic());
  }
}
