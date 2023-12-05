import 'package:get/get.dart';

import 'text_commands_logic.dart';

class TextCommandsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TextCommandsLogic());
  }
}
